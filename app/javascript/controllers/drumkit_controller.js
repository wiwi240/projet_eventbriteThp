import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["key"]

    connect() {
        this._boundKeydown = this.playSound.bind(this)
        window.addEventListener('keydown', this._boundKeydown)
    }

    disconnect() {
        window.removeEventListener('keydown', this._boundKeydown)
    }

    playSound(event) {
        const code = event.keyCode || event.which
        const key = this.keyTargets.find(k => k.dataset.key == code)
        const audio = document.querySelector(`audio[data-key="${code}"]`)
        if (!key || !audio) return

        audio.currentTime = 0
        audio.play()
        key.classList.add('playing')

        audio.addEventListener('ended', () => {
            key.classList.remove('playing')
        }, { once: true })
    }
}
