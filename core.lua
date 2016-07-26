NOC = {
	Version = '1.0',
	Branch = 'master',
	Interface = {
		addonColor = 'A330C9',
		Logo = NeP.Interface.Logo -- Temp until i get a logo
	},
}

-- NeP.Core.DebugMode = false

local Parse = NeP.DSL.parse
local Fetch = NeP.Interface.fetchKey


function NOC.ClassSetting(key)
	local name = '|cff'..NeP.Core.classColor('player')..'Class Settings'
	NeP.Interface.CreateSetting(name, function() NeP.Interface.ShowGUI(key) end)
end

function NOC.dynEval(condition, spell)
	return Parse(condition, spell or '')
end

function NoC.Splash()
	return true
end

NeP.library.register('NoC', {

-- Place custom functions here???

})


NeP.DSL.RegisterConditon("inMelee", function(target)
	return NeP.Core.UnitAttackRange('player', target, 'melee')
end)

NeP.DSL.RegisterConditon("inRanged", function(target)
	return NeP.Core.UnitAttackRange('player', target, 'ranged')
end)

NeP.DSL.RegisterConditon("power.regen", function(target)
	return select(2, GetPowerRegen(target))
end)

NeP.DSL.RegisterConditon("casttime", function(target, spell)
	local name, rank, icon, cast_time, min_range, max_range = GetSpellInfo(spell)
	return cast_time
end)

NeP.DSL.RegisterConditon("castwithin", function(target, spell)
	local SpellID = select(7, GetSpellInfo(spell))
	for k, v in pairs( NeP.ActionLog.log ) do
		local id = select(7, GetSpellInfo(v.description))
		if (id and id == SpellID and v.event == "Spell Cast Succeed") or tonumber( k ) == 20 then
			return tonumber( k )
		end
	end
	return 20
end)