import { Controller } from 'stimulus'
import StimulusReflex from 'stimulus_reflex'

export default class extends Controller {
    connect () {
        StimulusReflex.register(this)
    }

    beforeReflex (element, reflex) {
    }

    reflexSuccess (element, reflex, error) {
        $("img").lazyload();

        //temporal
        if(reflex == "Product#change_presentation" || reflex == "Product#change_variety") {

            var url_splitted = window.location.pathname.split("/");

            //Assign new slug.
            url_splitted[2] = element.dataset["internalCode"];

            //Assign new value to presentation.
            url_splitted[4] = element.dataset["presentationId"];

            //Assign new value to variation.
            url_splitted[6] = element.dataset["varietyId"];

            //Reform new url.
            var new_path = url_splitted.join("/");

            if(history.pushState) {
                var new_url = window.location.protocol + "//" + window.location.host + new_path;
                window.history.pushState( { path: new_url }, '', new_url);
            }
        }
    }

    reflexError (element, reflex, error) {
    }

    afterReflex (element, reflex) {
    }
}
