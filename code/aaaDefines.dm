




































































































































































































































































































































/proc/add_zero(t, u)
	while(length(t) < u)
		t = "0[t]"
	return t
/obj/bomb
	icon_state = "x"
	icon = 'screen1.dmi'
/obj/bomb/New()
	..()
	var/R = new /obj/item/weapon/assembly/r_i_ptank(loc)
	var/p3 = new /obj/item/weapon/tank/plasmatank(R)
	var/p1 = new /obj/item/weapon/radio/signaler(R)
	var/p2 = new /obj/item/weapon/igniter(R)

	R:part1 = p1
	R:part2 = p2
	R:part3 = p3

	p1:master = R
	p2:master = R
	p3:master = R

	R:status = 1
	p1:b_stat = 0
	p2:status = 1

	del(src)


















































































var/world_message = "\nVersion 40.70 - This version contains a slight remodellnig of the rooms as well as\nbug fixes.\n\nVersion 40.66 - Experiment with assemblies!\n\nVersion 40.5 Changes:\n\nFlashes have a slightly more offensive use when aimed at someone at CLOSE range. I mean close range.\nDue to this they have a slight ammo thing.\nSo give them to staff assistants security guards... You already got your tasers.\n\nNo air in shuttle fixed, dead men breathing, and dead men DNA fixed."
/atom
	var/level = 2
	var/flags

/atom/proc/burn(fi_amount)
/atom/movable/layer = 3


/atom/movable/Move()
	var/A = loc
	. = ..()
	m_flag = 1
	if(A != loc && (A && A:z == z))
		last_move = get_dir(A, loc)

/obj/proc/throwing(t_dir, rs)
	if(throwspeed <= 1) throwing = 0
	throwspeed--
	if(rs == 0) rs = 1
	if(throwing)
		if(rs == 1)
			step(src, t_dir)
			sleep(1)
			spawn(0) throwing(t_dir, rs)
		else if(rs > 1)
			for(var/t, t < rs, t++)
				step(src, t_dir)
			sleep(10)
			spawn(0) throwing(t_dir, rs)
		else
			step(src, t_dir)
			sleep(10 / rs)
			spawn(0) throwing(t_dir, rs)
	else density = 0

/turf
	var/intact = 0
/atom/movable
	var/last_move
	var/anchored = 0
	var/weight = 0
	var/m_flag = 1
/area
	var/fire
	layer = 1
	level = null
/obj
	var/throwspeed = 0
	var/throwing = null