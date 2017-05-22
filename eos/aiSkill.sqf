//INFANTRY SKILL
//[aimingAccuracy,aimingShake,aimingSpeed,spotDistance,spotTime,courage,reloadSpeed,commanding,general];
_InfSkillSet=[.28,.5,.7,.8,.6,.7,.7,1,.5];

//ARMOR SKILL
_ArmSkillSet=[.2,.45,.5,.6,.6,1,1,1,1];

//LIGHT VEHICLE SKILL
_LigSkillSet=[.15,.45,.6,.8,.8,1,1,1,1];

//HELICOPTER SKILL
_AirSkillSet=[.25,.45,.6,.4,.4,1,1,1,1];

//STATIC SKILL
_StSkillSet=[.20,.5,.6,.5,.5,1,1,1,1];
server setVariable["INFskill",_InfSkillSet];server setVariable["ARMskill",_ArmSkillSet];server setVariable["LIGskill",_LigSkillSet];server setVariable["AIRskill",_AirSkillSet];server setVariable["STskill",_StSkillSet];