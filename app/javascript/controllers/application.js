import { Application } from "@hotwired/stimulus"

import AutoSubmit from '@stimulus-components/auto-submit'
import RevealController from '@stimulus-components/reveal'

const application = Application.start()

application.register('auto-submit', AutoSubmit)
application.register('reveal', RevealController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
