if SERVER then
	AddCSLuaFile("nz_monkey_bomb.lua")
	SWEP.Weight			= 5
	SWEP.AutoSwitchTo	= false
	SWEP.AutoSwitchFrom	= true
end

if CLIENT then

	SWEP.PrintName     	    = "Monkey Bomb"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	
	SWEP.Category			= "nZombies"

	SWEP.NZHudIcon = Material("monkey_bomb.png", "unlitgeneric smooth")
end


SWEP.Author			= "Zet0r"
SWEP.Contact		= "youtube.com/Zet0r"
SWEP.Purpose		= "Throws a monkey bomb if you have any"
SWEP.Instructions	= "Let the gamemode give you it"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.HoldType = "slam"

SWEP.ViewModelFOV	= 72
SWEP.ViewModel	= "models/weapons/c_monkey_bomb.mdl"
SWEP.WorldModel	= "models/nzprops/monkey_bomb.mdl"
SWEP.UseHands = true
SWEP.vModel = true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.NextReload				= 1

function SWEP:Initialize()
	self:SetHoldType( "slam" )
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	
	self:SetHoldType( "slam" )
	timer.Simple(2, function() 
		if IsValid(self) then 
			self:SetHoldType("grenade") 
		end 
	end)
end

function SWEP:PrimaryAttack()
	if SERVER then
		self:ThrowBomb(500)
	end
end

function SWEP:ThrowBomb(force)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_THROW)
	
	local nade = ents.Create("nz_monkeybomb")
	local pos = self.Owner:EyePos() + (self.Owner:GetAimVector() * 20)
	local ang = Angle(0,(self.Owner:GetPos() - pos):Angle()[2]-90,0)
	nade:SetPos(pos)
	nade:SetAngles(ang)
	nade:Spawn()
	nade:Activate()
	nade:SetOwner(self.Owner)
	
	local nadePhys = nade:GetPhysicsObject()
		if !IsValid(nadePhys) then return end
	nadePhys:ApplyForceCenter(self.Owner:GetAimVector():GetNormalized() * force + self.Owner:GetVelocity())
	nade:EmitSound("nz/monkey/voice_throw/throw_0"..math.random(0,3)..".wav")
	
end

function SWEP:OnRemove()
	
end

--[[function SWEP:GetViewModelPosition( pos, ang )
 
 	local newpos = LocalPlayer():EyePos()
	local newang = LocalPlayer():EyeAngles()
	local up = newang:Up()
	
	newpos = newpos + LocalPlayer():GetAimVector()*6 - up*65
	
	return newpos, newang
 
end]]

sound.Add(
{
    name = "Weapon_nZ_MonkeyBomb.RaiseVox",
    channel = CHAN_VOICE,
    volume = 1.0,
    soundlevel = 60,
    sound = {
		"nz/monkey/voice_prime/raise_vox_00.wav",
		"nz/monkey/voice_prime/raise_vox_01.wav",
		"nz/monkey/voice_prime/raise_vox_02.wav",
		"nz/monkey/voice_prime/raise_vox_03.wav",
		"nz/monkey/voice_prime/raise_vox_04.wav",
		"nz/monkey/voice_prime/raise_vox_05.wav",
		"nz/monkey/voice_prime/raise_vox_06.wav",
		"nz/monkey/voice_prime/raise_vox_07.wav",
		"nz/monkey/voice_prime/raise_vox_08.wav",
		"nz/monkey/voice_prime/raise_vox_09.wav",
		"nz/monkey/voice_prime/raise_vox_10.wav",
		"nz/monkey/voice_prime/raise_vox_11.wav"
	}
})
sound.Add(
{
    name = "Weapon_nZ_MonkeyBomb.Knob",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 60,
    sound = "nz/monkey/wind_monkeybomb.wav"
})
sound.Add(
{
    name = "Weapon_nZ_MonkeyBomb.Hat",
    channel = CHAN_WEAPON,
    volume = 1.0,
    soundlevel = 60,
    sound = "nz/monkey/hat1.wav"
})
sound.Add(
{
    name = "Weapon_nZ_MonkeyBomb.Cymbal",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 70,
    sound = {
		"nz/monkey/cymbals/monk_cymb_00.wav",
		"nz/monkey/cymbals/monk_cymb_01.wav"
	}
})
sound.Add(
{
    name = "Weapon_nZ_MonkeyBomb.Cymbal1",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 70,
    sound = "nz/monkey/cymbals/monk_cymb_02.wav"
})
sound.Add(
{
    name = "Weapon_nZ_MonkeyBomb.Cymbal2",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 70,
    sound = "nz/monkey/cymbals/monk_cymb_03.wav"
})
sound.Add(
{
    name = "Weapon_nZ_MonkeyBomb.Cymbal3",
    channel = CHAN_ITEM,
    volume = 1.0,
    soundlevel = 70,
    sound = "nz/monkey/cymbals/monk_cymb_04.wav"
})
