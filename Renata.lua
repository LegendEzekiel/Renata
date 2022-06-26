SpellData = {
    ["Q"] = {
        ['range'] = 900,
        ['delay'] = 0.25,
        ['width'] = 140,
        ['speed'] = 1450,
        ['type'] = SkillshotType.SkillshotLine,
        ['collision'] = true,
        ['collisionFlags'] = bit.bor(CollisionFlag.CollidesWithYasuoWall, CollisionFlag.CollidesWithMinions, CollisionFlag.CollidesWithHeroes),
        ['minHitChance'] = HitChance.High,
        ['boundingRadiusMod'] = false
    },
    ["E"] = {
        ['range'] = 800,
        ['delay'] = 0.25,
        ['width'] = 220,
        ['speed'] = 1450,
        ['type'] = SkillshotType.SkillshotLine,
        ['collision'] = false,
        ['collisionFlags'] = CollisionFlag.CollidesWithYasuoWall,
        ['minHitChance'] = HitChance.High,
        ['boundingRadiusMod'] = false
    },

    ["R"] = {
        ['maxRange'] = 2000,
        ['range'] = 2000,
        ['delay'] = 0.75,
        ['width'] = 500,
        ['speed'] = 650,
        ['type'] = SkillshotType.SkillshotLine,
        ['collision'] = true,
        ['collisionFlags'] = CollisionFlag.CollidesWithYasuoWall,
        ['minHitChance'] = HitChance.High,
        ['boundingRadiusMod'] = true
    },

}

My = Game.localPlayer;
Menu = UI.Menu.CreateMenu(My.charName, Game.localPlayer.displayName, 2);
Champions.CreateBaseMenu(Menu, 0);
Q = nil;
W = nil;
E = nil;
R = nil;
MenuConfig = {
    ["Combo"] = {
        ['Use Q'] = nil;
        ['Use Q2'] = nil;
        ['Use Q Check'] = { };
        ['Use Q Objcet'] = {};
        ['Use Q2 Objcet'] = {};
        ['Use Q Mode'] = {};
        ['Use W'] = nil;
        ['Use W Objcet'] = {};
        ['Use W Level'] = {};

        ['Use E'] = nil;
        ['Use R'] = nil;
        ['Use Key R'] = nil;
        ['Use R Number'] = nil;
    },
    ["Harass"] = {
        ['Use Q'] = nil;
        ['Use E'] = nil;
    },
    ["Auto"] = {
        ['Auto W'] = nil;
        ['Use W Objcet'] = {};
        ['Use W Perd'] = {};
        ['Use W HP'] = {};

    },
    ['Use Range'] = {
        ['Q'] = nil;
        ['W'] = nil;
        ['E'] = nil;
        ['R'] = nil;

    },
    ['Draw'] = {

    }


};

local function Init()


    Champions.Q = (SDKSpell.Create(SpellSlot.Q, MenuConfig['Use Range']['Q'].value, DamageType.Magical))
    Champions.W = (SDKSpell.Create(SpellSlot.W, MenuConfig['Use Range']['W'].value, DamageType.Magical))
    Champions.E = (SDKSpell.Create(SpellSlot.E, MenuConfig['Use Range']['E'].value, DamageType.Magical))
    Champions.R = (SDKSpell.Create(SpellSlot.R, MenuConfig['Use Range']['R'].value, DamageType.Magical))

    Champions.Q:SetSkillshot(
            SpellData['Q']['delay'],
            SpellData['Q']['width'],
            SpellData['Q']['speed'],
            SpellData['Q']['type'],
            SpellData['Q']['collision'],
            SpellData['Q']['collisionFlags'],
            SpellData['Q']['minHitChance'],
            SpellData['Q']['boundingRadiusMod']
    );

    Champions.E:SetSkillshot(
            SpellData['E']['delay'],
            SpellData['E']['width'],
            SpellData['E']['speed'],
            SpellData['E']['type'],
            SpellData['E']['collision'],
            SpellData['E']['collisionFlags'],
            SpellData['E']['minHitChance'],
            SpellData['E']['boundingRadiusMod']
    );

    Champions.R:SetSkillshot(
            SpellData['R']['delay'],
            SpellData['R']['width'],
            SpellData['R']['speed'],
            SpellData['R']['type'],
            SpellData['R']['collision'],
            SpellData['R']['collisionFlags'],
            SpellData['R']['minHitChance'],
            SpellData['R']['boundingRadiusMod']
    );

    Q = Champions.Q;
    W = Champions.W;
    E = Champions.E;
    R = Champions.R;
end

local function AutoLanguage(str)


    local i_lg = UI:GetLanguage(); --0=英语  1=中文
    if i_lg == 0 then
        --英语

        return str;
    end

    if i_lg == 1 then
        --中文
        local strR = string.gsub(str, "Combo", "连招");
        strR = string.gsub(strR, "Settings", "设置");
        strR = string.gsub(strR, "Use", "使用");
        strR = string.gsub(strR, "Enemy", "敌方");
        strR = string.gsub(strR, "Auto", "自动");
        strR = string.gsub(strR, "Range", "范围");
        strR = string.gsub(strR, "Drawing", "绘制");
        strR = string.gsub(strR, "Olny", "仅");
        strR = string.gsub(strR, "Pull", "拉");
        strR = string.gsub(strR, "Turret", "塔");
        strR = string.gsub(strR, "Or", "或");
        strR = string.gsub(strR, "Push", "推");
        strR = string.gsub(strR, "Away", "走");
        strR = string.gsub(strR, "To", "到");
        strR = string.gsub(strR, "Down", "下");
        strR = string.gsub(strR, "My", "自己");
        strR = string.gsub(strR, "Pred", "预测");
        strR = string.gsub(strR, "Damage", "伤害值");
        strR = string.gsub(strR, "Current", "当前");
        strR = string.gsub(strR, "Cast", "施法");
        strR = string.gsub(strR, "Check", "检查");
        return strR;

    end
    return str;

end

local function LoadMenu()


    local Combo = Menu:AddMenu("Combo", AutoLanguage("Combo"));
    MenuConfig['Combo']['Use Q'] = Combo:AddCheckBox("useQ", AutoLanguage('Use Q'));

    local WhitelistQ = Combo:AddMenu("QSettings", AutoLanguage("Q Settings"));
    for _, enemy in ObjectManager.enemyHeroes:pairs() do
        local qCharMenu = WhitelistQ:AddMenu(enemy.charName .. "Menu", enemy.charName);

        MenuConfig['Combo']['Use Q Objcet'][enemy.charName] = qCharMenu:AddCheckBox('use', AutoLanguage('Use Q1'));
        MenuConfig['Combo']['Use Q2 Objcet'][enemy.charName] = qCharMenu:AddCheckBox('use2', AutoLanguage('Use Q2'));
        MenuConfig['Combo']['Use Q Check'][enemy.charName] = qCharMenu:AddCheckBox('usecheck', AutoLanguage('Check Olny Push To Enemy  Use'), false);
        if enemy.isMelee then
            MenuConfig['Combo']['Use Q Mode'][enemy.charName] = qCharMenu:AddList("model", "Q Model", { AutoLanguage("Pull To My Or Pull To (Turret Down) Mode:0"), AutoLanguage("Push Away Or Push To(Turret Down) Or Push To Enemy Mode:1"), AutoLanguage("Pull To My Or Push To (Turret Down) Or Push To Enemy Mode:2") }, 1);

        else
            MenuConfig['Combo']['Use Q Mode'][enemy.charName] = qCharMenu:AddList("model", "Q Model", { AutoLanguage("Pull To My Or Pull To (Turret Down) Mode:0"), AutoLanguage("Push Away Or Push To(Turret Down) Or Push To Enemy Mode:1"), AutoLanguage("Pull To My Or Push To (Turret Down) Or Push To Enemy Mode:2") }, 2);

        end


    end
    MenuConfig['Combo']['Use Q2'] = Combo:AddCheckBox("useQ2", AutoLanguage('Use Q2'));

    --MenuConfig['Combo']['Use W'] = Combo:AddCheckBox("useW", 'Use W');
    --local Wmenu = Combo:AddMenu("Wsetting", "W Settings");
    --for _, ally in ObjectManager.allyHeroes:pairs() do
    --    local charMenu = Wmenu:AddMenu(ally.charName .. "Menu", ally.charName);
    --    MenuConfig['Combo']['Use W Objcet'][ally.charName] = charMenu:AddCheckBox(ally.charName .. "Use", "Use");
    --    MenuConfig['Combo']['Use W Objcet'][ally.charName]:AddTooltip("In combo mode,Use after automatic attack");
    --
    --    MenuConfig['Combo']['Use W Level'][ally.charName] = charMenu:AddSlider(ally.charName .. "Level", "Priority Level", 1, 1, 5);
    --
    --
    --end

    MenuConfig['Combo']['Use E'] = Combo:AddCheckBox("useE", AutoLanguage('Use E'));

    MenuConfig['Combo']['Use R'] = Combo:AddCheckBox("useR", AutoLanguage('Use R'));
    MenuConfig['Combo']['Use Key R'] = Combo:AddKeyBind("keyR", ("Key R"), 84, false, false);
    MenuConfig['Combo']['Use Key R']:PermaShow(true, true);
    MenuConfig['Combo']['Use R Number'] = Combo:AddSlider("useRrange", AutoLanguage('Use R >= X Enemy'), 3, 1, 5)

    MenuConfig['Combo']['Use R Number']:PermaShow(true, true);

    local Harass = Menu:AddMenu("Harass", "Harass");
    MenuConfig['Harass']['Use Q'] = Harass:AddCheckBox("useQ", AutoLanguage('Use Q'))
    MenuConfig['Harass']['Use E'] = Harass:AddCheckBox("useE", AutoLanguage('Use E'));

    local Auto = Menu:AddMenu("Auto", "Auto");
    MenuConfig['Auto']['Auto W'] = Auto:AddCheckBox("autoW", AutoLanguage('Auto W'));

    local autoWsettings = Auto:AddMenu("Wsetting", AutoLanguage("W Settings"));

    for _, ally in ObjectManager.allyHeroes:pairs() do
        local autoCharMenu = autoWsettings:AddMenu(ally.charName .. "Menu", ally.charName);

        MenuConfig['Auto']['Use W Objcet'][ally.charName] = autoCharMenu:AddCheckBox(ally.charName .. "Use", AutoLanguage("Use"))

        MenuConfig['Auto']['Use W HP'][ally.charName] = autoCharMenu:AddSlider(ally.charName .. "HP", "Hp <= X%", 15, 1, 100);

        MenuConfig['Auto']['Use W Perd'][ally.charName] = autoCharMenu:AddCheckBox(ally.charName .. "Perd", AutoLanguage("Pred Damage >= Current HP Use"));


    end

    local UseRange = Menu:AddMenu("useRange", AutoLanguage("Use Range Settings"));
    MenuConfig['Use Range']['Q'] = UseRange:AddSlider("useQRange", AutoLanguage('Use Q Range'), 800, 1, 900, 10, function(s)
        Champions.Q = (SDKSpell.Create(SpellSlot.Q, MenuConfig['Use Range']['Q'].value, DamageType.Magical))
    end)
    MenuConfig['Use Range']['W'] = UseRange:AddSlider("useWRange", AutoLanguage('Use W Range'), 800, 1, 800, 1, function(s)
        Champions.W = (SDKSpell.Create(SpellSlot.W, MenuConfig['Use Range']['W'].value, DamageType.Magical))
    end)
    MenuConfig['Use Range']['E'] = UseRange:AddSlider("useERange", AutoLanguage('Use E Range'), 800, 1, 800, 1, function(s)
        Champions.E = (SDKSpell.Create(SpellSlot.E, MenuConfig['Use Range']['E'].value, DamageType.Magical))
    end)
    MenuConfig['Use Range']['R'] = UseRange:AddSlider("useRRange", AutoLanguage('Use R Range'), 800, 1, 2000, 10, function(s)
        Champions.R = (SDKSpell.Create(SpellSlot.R, MenuConfig['Use Range']['R'].value, DamageType.Magical))
    end)

    --draw
    local draw = Menu:AddMenu("draw", "Drawing", false);

    Init();
    Champions.CreateColorMenu(draw, true)

end

LoadMenu();
local function GetEnemyQ2(T)

    for _, t in ObjectManager.enemyHeroes:pairs() do
        if T.position:Distance(t.position) <= 400 and t.networkId ~= T.networkId then
            return t;
        end
    end

    return nil;

end

local function UseQBindPred()

    if Q:Ready() then
        local SpellName = My.spellBook:GetSpellEntry(0):GetName();
        --print(SpellName)
        if SpellName == "RenataQ" then
            local T = TargetSelector.GetTarget(Q.range, DamageType.Magical);
            if T then
                if MenuConfig['Combo']['Use Q Objcet'][T.charName].value then
                    if T:IsValidTarget(Q.range) then
                        local Q2Mode = MenuConfig['Combo']['Use Q Mode'][T.charName].value;
                        local t2 = nil;
                        if MenuConfig['Combo']['Use Q Check'][T.charName].value then
                            t2 = GetEnemyQ2(T);
                        end

                        local Pred = Q:GetPrediction(T);

                        if Pred and Pred.hitchance >= HitChance.High then
                            local myIsEnemyRange = My.position:Distance(Pred.castPosition);
                            if myIsEnemyRange <= Q.range then

                                if MenuConfig['Combo']['Use Q Check'][T.charName].value and Q2Mode ~= 0 and myIsEnemyRange >= 300 then
                                    if t2 then
                                        Q:Cast(t2.position);
                                    end

                                else
                                    Q:Cast(Pred.castPosition);
                                end


                            end


                        end


                    end


                end

            end


        end

    end

end

local function UseQBindPredByHas()
    if Q:Ready() then
        local SpellName = My.spellBook:GetSpellEntry(0):GetName();
        --print(SpellName)
        if SpellName == "RenataQ" then
            local T = TargetSelector.GetTarget(Q.range, DamageType.Magical);
            if T then
                if T:IsValidTarget(Q.range) then
                    local Pred = Q:GetPrediction(T);
                    if Pred and Pred.hitchance >= HitChance.High then
                        if My.position:Distance(Pred.castPosition) <= Q.range then
                            Q:Cast(Pred.castPosition);
                        end
                    end
                end
            end
        end
    end

end

local function UseE()
    if E:Ready() then
        local T = TargetSelector.GetTarget(E.range, DamageType.Magical);
        if T then
            if T:IsValidTarget(E.range) then
                local Pred = E:GetPrediction(T);
                if Pred and Pred.hitchance >= HitChance.High then
                    if My.position:Distance(Pred.castPosition) <= E.range then
                        E:Cast(Pred.castPosition);
                    end
                end


            end
        end


    end


end

local function UseR()
    if R:Ready() then
        local AoePosition = R:GetCastOnBestAOEPosition(MenuConfig['Combo']['Use R Number'].value)

        if AoePosition:IsValid() then
            R:Cast(AoePosition);
        end
    end


end

local function Combo()


    if MenuConfig['Combo']['Use Q'].value then
        UseQBindPred();
    end

    if MenuConfig['Combo']['Use E'].value then
        UseE();
    end

    if MenuConfig['Combo']['Use R'].value then
        UseR();
    end
    --
    --if MenuConfig['Combo']['Use W'].value then
    --    UseWCombo();
    --end
end

local function GetTurr(Tg)


    for _, turr in ObjectManager.allyTurrets:pairs() do
        --print(My.position:Distance(turr.position))
        --print(turr.isAlive)
        if turr.isAlive and Tg.isEnemy and turr.position:Distance(Tg.position) <= 1100 then
            return turr;
        end


    end

    return nil;

end
local function Q2(t)
    if My.position:Distance(t.position) <= 1500 and t.isAlive then
        for i, v in t.buffManager.buffs:pairs() do
            if v.isValid then
                if v:GetName() == 'RenataQ' then
                    local Q2Mode = MenuConfig['Combo']['Use Q Mode'][t.charName].value;
                    if Q2Mode == 0 then

                        local turr = GetTurr(t);
                        if turr then
                            Q:Cast(turr.position);
                            return ;
                        else
                            Q:Cast(My.position);
                            return ;
                        end

                    end

                    if Q2Mode == 1 then
                        local mode_1 = GetEnemyQ2(t);
                        if mode_1 then
                            Q:Cast(mode_1.position);
                            return ;
                        else


                            local turr = GetTurr(t);
                            if turr then
                                Q:Cast(turr.position);
                                return ;
                            else

                                local HpB = (t.totalHealth / t.totalMaxHealth) * 100;
                                if t.totalMaxHealth >= 3000 then
                                    if HpB <= 15 then
                                        Q:Cast(My.position);
                                        return ;
                                    end
                                elseif t.totalMaxHealth >= 2000 then
                                    if HpB <= 20 then
                                        Q:Cast(My.position);
                                        return ;
                                    end
                                elseif t.totalMaxHealth >= 1000 then
                                    if HpB <= 30 then
                                        Q:Cast(My.position);
                                        return ;
                                    end
                                else
                                    if HpB <= 30 then
                                        Q:Cast(My.position);
                                        return ;
                                    end
                                end

                                local CastPos = My.position:RelativePos(t.position, 20000)
                                Q:Cast(CastPos);
                                return ;
                            end

                        end
                    end

                    if Q2Mode == 2 then

                        local mode_1 = GetEnemyQ2(t);

                        if mode_1 then
                            Q:Cast(mode_1.position);
                            return ;
                        else
                            local turr = GetTurr(t);
                            if turr then
                                Q:Cast(turr.position);
                                return ;
                            else
                                Q:Cast(My.position);
                                return ;
                            end


                        end
                    end
                end
            end
        end
    end

end

local function UseQ2()
    --RenataQRecast  Q2
    if MenuConfig['Combo']['Use Q2'].value and Q:Ready() then
        local SpellName = My.spellBook:GetSpellEntry(0):GetName();
        if SpellName == "RenataQRecast" then
            for _, t in ObjectManager.enemyHeroes:pairs() do
                if MenuConfig['Combo']['Use Q2 Objcet'][t.charName].value then
                    Q2(t);
                elseif (Champions.Harass) then
                    Q2(t);
                end
            end
        end

    end
end

local function AutoWLogicHP()

    if W:Ready() then
        for _, ally in ObjectManager.allyHeroes:pairs() do
            --print(My.position:Distance(ally.position));
            --print(W.range);
            if My.position:Distance(ally.position) <= W.range and ally.isAlive then
                if ally.isAlive and MenuConfig['Auto']['Use W Objcet'][ally.charName].value then
                    local HpB = (ally.totalHealth / ally.totalMaxHealth) * 100;
                    local SetHpB = MenuConfig['Auto']['Use W HP'][ally.charName].value;
                    if HpB <= SetHpB then
                        local DamageV = HealthPrediction.GetIncomingDamage(ally, 0.1, true, true)
                        if DamageV > 50 then
                            W:Cast(ally);
                            return ;
                        end
                    end

                    if MenuConfig['Auto']['Use W Perd'][ally.charName].value then
                        local DamageV = HealthPrediction.GetIncomingDamage(ally, 0.1, true, true)
                        if DamageV >= ally.totalHealth - 100 then
                            W:Cast(ally);
                            return ;
                        end
                    end

                end

            end


        end
    end


end

local function Harass()
    if MenuConfig['Harass']['Use Q'].value then
        UseQBindPredByHas();
    end

    if MenuConfig['Harass']['Use E'].value then
        UseE();
    end
end
local function ontick()
    if My.isAlive == false then
        return ;
    end

    --UseQ2();

    if MenuConfig['Auto']['Auto W'].value then
        AutoWLogicHP();
    end

    if Champions.Combo then
        Combo();
        UseQ2();
    end

    if Champions.Harass then

        Harass();
        UseQ2();

    end



    --Key R
    if MenuConfig['Combo']['Use Key R'].value then
        UseR();
    end

end

Callback.Bind(CallbackType.OnTick, ontick)

local fontSize = 16
--Callback.Bind(CallbackType.OnImguiDraw, function()
--    local dmg = HealthPrediction.GetIncomingDamage(Game.localPlayer, 0.1, true, true)
--    local text = string.format("Damage: %d", dmg)
--    local tX, tY = Renderer.CalcTextSize(text, fontSize)
--    Renderer.DrawWorldText(text, Game.localPlayer.position, Math.Vector2(-tX / 2, 0), fontSize)
--end)




