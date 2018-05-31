/datum/antagonist/centassassin
	name = "CentCom Assassin"
	show_name_in_check_antagonists = TRUE
	show_in_antagpanel = FALSE
	var/datum/objective/mission

/datum/antagonist/centassassin/greet()
	to_chat(owner, "<B><font size=3 color=red>You are a CentCom Dispatched Assassin.</font></B>")
	to_chat(owner, "Central Command is sending you to [station_name()] with the task: [mission.explanation_text]")

/datum/antagonist/centassassin/proc/equip_official()
	var/mob/living/carbon/human/H = owner.current
	if(!istype(H))
		return
	H.equipOutfit(/datum/outfit/centassassin)

	if(CONFIG_GET(flag/enforce_human_authority))
		H.set_species(/datum/species/human)

/datum/antagonist/centassassin/proc/forge_objectives()
	if(!mission)
		var/datum/objective/missionobj = new
		missionobj.owner = owner
		missionobj.explanation_text = "Conduct a routine preformance review of [station_name()] and its Captain."
		missionobj.completed = 1
		mission = missionobj
	objectives |= mission
	owner.objectives |= objectives

/datum/antagonist/centassassin/on_gain()
	forge_objectives()
	. = ..()
	equip_official()
