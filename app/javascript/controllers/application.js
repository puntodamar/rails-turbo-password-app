import { Application } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

window.bootstrap = bootstrap
const application = Application.start()

export { application }
