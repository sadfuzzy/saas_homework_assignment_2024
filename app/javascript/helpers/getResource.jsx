async function getResource(url) {
  const token = document.querySelector('[name=csrf-token]').content;
  const res = await fetch(url, { headers: new Headers({ 'X-CSRF-TOKEN': token }) });

  if (!res.ok) {
    throw new Error(`Could not fetch ${url}, received ${res.status}`);
  }

  return await res.json();
}

export default getResource;
