const _alert = msg => {
  const c = $("#alert-modal"), o = $(".modal:visible")
  return new Promise((resolve, reject) => {
    $(".modal-title", c).text(msg)
    $("#alert-ok").off().click(() => {
      c.off().modal("hide"); o.modal("show"); resolve(true)
    })
    o.modal("hide")
    c.on("hidden.bs.modal", () => {
      c.off(); o.modal("show"); resolve(false)
    }).modal()
  })
}
