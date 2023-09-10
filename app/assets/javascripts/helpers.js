
function processElementById(elementId) {
  let element = document.getElementById(elementId)
  let content = element.innerHTML;
  element.innerHTML = content;
  htmx.process(element);
}
