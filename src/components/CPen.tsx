import React from 'react';

export default function CPen({ id, title }) {
  return (
    <iframe 
      height="400" 
      style={{ width: '100%', marginBottom: '20px', borderRadius: '8px', border: '1px solid #ddd' }} 
      src={`https://codepen.io/team/codepen/embed/${id}?default-tab=html%2Ccss%2Cresult&editable=true`}
      title={title}
      loading="lazy"
      allowTransparency={true}
      allowFullScreen={true}
    />
  );
}