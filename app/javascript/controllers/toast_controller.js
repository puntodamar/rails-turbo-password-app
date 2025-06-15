import {Controller} from "@hotwired/stimulus";

class ToastController extends Controller {
    connect() {
        console.log("Hello from toast")
        const toast = bootstrap.Toast.getOrCreateInstance(this.element)
        toast.show()
    }

}

export default ToastController