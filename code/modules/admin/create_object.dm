var/create_object_html = null
var/list/create_object_forms = list(
	/obj, /obj/structure, /obj/machinery, /obj/effect,
	/obj/item, /obj/item/clothing, /obj/item/stack, /obj/item/device,
	/obj/item/weapon, /obj/item/weapon/reagent_containers, /obj/item/weapon/gun)

/datum/admins/proc/create_object(mob/user)
	if (!create_object_html)
		var/objectjs = null
		objectjs = list2text(typesof(/obj), ";")
		create_object_html = file2text('html/create_object.html')
		create_object_html = replace_text(create_object_html, "null /* object types */", "\"[objectjs]\"")

	user << browse(replace_text(create_object_html, "/* ref src */", "\ref[src]"), "window=create_object;size=425x475")


/datum/admins/proc/quick_create_object(mob/user)
	var/path = input("Select the path of the object you wish to create.", "Path", /obj) in create_object_forms
	var/html_form = create_object_forms[path]

	if (!html_form)
		var/objectjs = list2text(typesof(path), ";")
		html_form = file2text('html/create_object.html')
		html_form = replace_text(html_form, "null /* object types */", "\"[objectjs]\"")
		create_object_forms[path] = html_form

	user << browse(replace_text(html_form, "/* ref src */", "\ref[src]"), "window=qco[path];size=425x475")