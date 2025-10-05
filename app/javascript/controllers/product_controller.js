import ApplicationController from './application_controller'

export default class extends ApplicationController {
    connect () {
        StimulusReflex.register(this)
    }

    change_presentation(element, reflex, error) {
        console.log(element);
    }

   updateSuccess(element, reflex) {
     console.log('Updated Successfully.');
   }
}
