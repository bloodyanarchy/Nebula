// the light switch
// can have multiple per area
// can also operate on non-loc area through "otherarea" var
/obj/machinery/light_switch
	name = "light switch"
	desc = "It turns lights on and off. What are you, simple?"
	icon = 'icons/obj/power.dmi'
	icon_state = "light0"
	anchored = 1.0
	idle_power_usage = 20
	power_channel = LIGHT
	var/on = 0
	var/area/connected_area = null
	var/other_area = null
	var/image/overlay

	construct_state = /decl/machine_construction/wall_frame/panel_closed/simple
	frame_type = /obj/item/frame/button/light_switch
	uncreated_component_parts = list(
		/obj/item/stock_parts/power/apc/buildable
	)
	base_type = /obj/machinery/light_switch/buildable

/obj/machinery/light_switch/buildable
	uncreated_component_parts = null

/obj/machinery/light_switch/on
	on = TRUE

/obj/machinery/light_switch/Initialize()
	. = ..()
	if(other_area)
		src.connected_area = locate(other_area)
	else
		src.connected_area = get_area(src)

	if(!connected_area)
		return // Test instance spawned in nullspace
	if(name == initial(name))
		SetName("light switch ([connected_area.name])")

	connected_area.set_lightswitch(on)
	update_icon()

/obj/machinery/light_switch/on_update_icon()
	if(!overlay)
		overlay = image(icon, "light1-overlay")
		overlay.plane = EFFECTS_ABOVE_LIGHTING_PLANE
		overlay.layer = ABOVE_LIGHTING_LAYER

	overlays.Cut()
	if(stat & (NOPOWER|BROKEN))
		icon_state = "light-p"
		set_light(0)
	else
		icon_state = "light[on]"
		overlay.icon_state = "light[on]-overlay"
		overlays += overlay
		set_light(0.1, 0.1, 1, 2, on ? "#82ff4c" : "#f86060")

/obj/machinery/light_switch/examine(mob/user, distance)
	. = ..()
	if(distance)
		to_chat(user, "A light switch. It is [on? "on" : "off"].")

/obj/machinery/light_switch/proc/set_state(var/newstate)
	if(on != newstate)
		on = newstate
		connected_area.set_lightswitch(on)
		update_icon()

/obj/machinery/light_switch/proc/sync_state()
	if(connected_area && on != connected_area.lightswitch)
		on = connected_area.lightswitch
		update_icon()
		return 1

/obj/machinery/light_switch/interface_interact(mob/user)
	if(CanInteract(user, DefaultTopicState()))
		playsound(src, "switch", 30)
		set_state(!on)
		return TRUE