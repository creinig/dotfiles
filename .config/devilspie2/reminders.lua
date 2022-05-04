debug_print("Window Name: " .. get_window_name());
debug_print("Application name: " .. get_application_name());
debug_print("Window type: " .. get_window_type());

if (string.find(get_window_name(), "Reminder") 
    and (get_application_name() == "Thunderbird"))  then
    debug_print("  -> always on top");
    make_always_on_top()
end
