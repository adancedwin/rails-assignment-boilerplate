import "@hotwired/turbo-rails"

document.addEventListener('turbo:click', async (event) => {
  event.preventDefault()

  await animateOut()

  event.detail.resume()
})
