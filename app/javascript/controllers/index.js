// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import HelloController from "./hello_controller"
import ToastController from "./toast_controller";
import SearchController from "./search_controller";
import ClipboardController from "./clipboard_controller";
import TogglePasswordController from "./toggle_password_controller";
import {application} from "./application";

application.register("hello", HelloController)
application.register("toast", ToastController)
application.register("search", SearchController)
application.register("clipboard", ClipboardController)
application.register("toggle-password", TogglePasswordController)