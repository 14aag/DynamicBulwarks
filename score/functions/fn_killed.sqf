/**
*  fn_killed
*
*  Event handler for unit death.
*
*  Domain: Event
**/

if (isServer) then {
    _unit = _this select 0;
    _killer = _this select 1;
    _instigator = _this select 2;
    if ((isNull _instigator) || {_killer == _unit}) then {
        private _aceSource = _unit getVariable ["ace_medical_lastDamageSource", objNull];
        if ((!isNull _aceSource) && {_aceSource != _unit}) then {
            _instigator = _aceSource;
        };
    };
    if (isPlayer _instigator) then {
        _kilPointMulti = _unit getVariable "killPointMulti";
        [_instigator, (SCORE_KILL * _kilPointMulti)] call killPoints_fnc_add;
        _killPoints = (SCORE_KILL * _kilPointMulti);
        _pointsArr = _unit getVariable "points";
        {
          _killPoints = _killPoints + _x;
        } forEach _pointsArr;

        [_unit, round (SCORE_KILL * _kilPointMulti), [0.1, 1, 0.1]] remoteExec ["killPoints_fnc_hitMarker", _instigator];
    };
};
