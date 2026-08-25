AddCSLuaFile( )

ENT.Type = "anim"

ENT.PrintName		= "pap_weapon_fly"
ENT.Author			= "Zet0r"
ENT.Contact			= "Don't"
ENT.Purpose			= ""
ENT.Instructions	= ""

function ENT:SetupDataTables()
	self:NetworkVar( "String", 0, "WeaponClass")
	self:NetworkVarNotify("WeaponClass", self.SetupNewWeapon)
end

function ENT:Initialize()
	if SERVER then
		self:SetUseType( SIMPLE_USE )
		self:SetModel(self.WorldModel or "models/weapons/w_rif_ak47.mdl")
		--self:SetWeaponClass(self.WepClass)
	end

	self:SetSolid( SOLID_OBB )
	self:SetMoveType(MOVETYPE_NOCLIP)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	--self:PhysicsInitBox(Vector(-5, -10, -3), Vector(5, 10, 3))
	--self:GetPhysicsObject():EnableCollisions(false)
	self:SetNotSolid(true)
	self:DrawShadow( false )
	self.TriggerPos = self:GetPos()
	
end

function ENT:SetupNewWeapon(name, old, new)
	if IsValid(self.button) then
		self.button:SetWepClass(new)
	end
	
	local weapon = weapons.Get(new)
	local model = "models/weapons/w_rif_ak47.mdl"
	if weapon != nil then
		model = weapon.WM or weapon.WorldModel
		self.WorldModel = model
		if weapon.DrawWorldModel then self.WorldModelFunc = weapon.DrawWorldModel end
	end
	self:SetModel(model)
end

function ENT:CreateTriggerZone(reroll)
	if SERVER then
		self.button = ents.Create("pap_weapon_trigger")
		self.button:SetPos(self.TriggerPos)
		self.button:SetAngles(self:GetAngles() - Angle(90,90,0))
		self.button:Spawn()
		self.button:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
		self.button.RerollingAtts = reroll
		self.button:SetPaPOwner(self.Owner)
		self.button.wep = self
		self.button:SetWepClass(self:GetWeaponClass())
	end
end

function ENT:OnRemove()
	if IsValid(self.button) then self.button:Remove() end
end

if CLIENT then
	function ENT:Draw()
		-- We can use the stored world model draw function from the original weapon, but if it doesn't exist or errors, then just draw model
		if !self.WorldModelFunc or !pcall(self.WorldModelFunc, self) then self:DrawModel() end
	end
end
