import EasyMDE from "easymde";
import "../node_modules/easymde/dist/easymde.min.css";

const el = document.getElementById('mde-editor');
if (el) {
  const form = document.forms[0];
  const slug = document.getElementById('slug')
  const title = form.elements.namedItem('page[title]');
  const submit = document.querySelector('input[type="submit"]');
  
  const initialValues = Array
    .from(form.elements)
    .reduce((vals, { name, value }) => {
      return name && !name.startsWith('_')
      ? { ...vals, [name]: value}
      : vals
    }, {});
  
  const handleChange = () => {
    submit.disabled = !Object
      .keys(initialValues)
      .some(name => {
        return form.elements.namedItem(name).value != initialValues[name]
      });
    slug.textContent = "/docs/" + slugify(title.value);
  };

  form.addEventListener('input', handleChange);
  
  const easymde = new EasyMDE({
    element: el,
    hideIcons: ['image'],
    indentWithTabs: false,
    forceSync: true,
    previewClass: 'editor-preview markdown-body'
  });
  
  easymde.codemirror.on("change", handleChange);
}

function slugify(text) {
  return text
    .replace(/['’]s/g, "s")
    .trim()
    .toLowerCase()
    .replace(/([^a-z0-9가-힣])+/g, "-");
}