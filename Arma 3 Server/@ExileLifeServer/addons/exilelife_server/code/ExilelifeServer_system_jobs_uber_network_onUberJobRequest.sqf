/**
                    * ExilelifeServer_system_jobs_uber_network_onUberJobRequest
                    *
                    * Exile Mod
                    * www.exilemod.com
                    * © 2016 Exile Mod Team
                    *
                    * This work is licensed under the Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License. 
                    * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/4.0/.
                    * 
                    * Permission granted to ExileLife Dev Team to overwrite files and redistribute them
                    *
                    */

                    private["_sessionID","_parameters","_uberJobID","_player","_job"];
_sessionID = _this select 0;
_parameters = _this select 1;
_uberJobID = _parameters select 0;
try
{
    _player = _sessionID call ExileServer_system_session_getPlayerObject;
    if (isNull _player) then
    {
        throw "player doesnt exist!";
    };
    if !(alive _player) then
    {
        throw "player is dead!";
    };
    _job = _uberJobID call ExileLifeServer_system_jobs_uber_removeJob;
    if (_job isEqualTo [])then{
        throw "The job is no longer available!";
    };
    {
        [_x,_job] call ExileLifeServer_system_jobs_uber_removeJobOffer;
    }forEach allPlayers;
    [_sessionID,_job] call ExilelifeServer_system_jobs_process_network_startUberJobRequest;
}
catch
{
    format["ExileLifeServer_system_jobs_uber_network_onUberJobRequest: %1",_exception] call ExileServer_util_log;
};