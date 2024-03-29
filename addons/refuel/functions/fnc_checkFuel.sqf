#include "..\script_component.hpp"
/*
 * Author: GitHawk
 * Get the remaining fuel amount
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Fuel Source <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, fuelTruck] call ace_refuel_fnc_checkFuel
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_source", objNull, [objNull]]];

private _fuel = [_source] call FUNC(getFuel);

[
    GVAR(progressDuration) * 2,
    [_unit, _source, _fuel],
    {
        params ["_args"];
        _args params [["_unit", objNull, [objNull]], ["_source", objNull, [objNull]], ["_fuel", 0, [0]]];
        if (_fuel > 0 ) then {
            [QEGVAR(common,displayTextStructured), [[LSTRING(Hint_RemainingFuel), _fuel], 2, _unit], _unit] call CBA_fnc_targetEvent;
        } else {
            [QEGVAR(common,displayTextStructured), [LSTRING(Hint_Empty), 2, _unit], _unit] call CBA_fnc_targetEvent;
        };
        true
    },
    {true},
    localize LSTRING(CheckFuelAction),
    {true},
    [INTERACT_EXCEPTIONS]
] call EFUNC(common,progressBar);
