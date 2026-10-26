import React, { useState, useEffect } from 'react';

function ExpenseForm({ onAddExpense, editData }) {
  const [title, setTitle] = useState('');
  const [amount, setAmount] = useState('');
  const [category, setCategory] = useState('Yemek');
  const [currency, setCurrency] = useState('MKD');

  useEffect(() => {
    if (editData) {
      setTitle(editData.title);
      setAmount(editData.amount);
      setCategory(editData.category);
      setCurrency(editData.currency);
    }
  }, [editData]);

  const handleSubmit = (e) => {
    e.preventDefault();
    if (!title || !amount) return;

    onAddExpense({ 
      title, 
      amount: parseFloat(amount), 
      category, 
      currency 
    });

    setTitle('');
    setAmount('');
    setCategory('Yemek');
    setCurrency('MKD');
  };

  return (
    <div className="p-3">
      <h5 className="text-primary mb-3 fw-bold">
        {editData ? 'Harcamayı Güncelle' : 'Yeni Harcama Ekle'}
      </h5>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <input 
            type="text" className="form-control shadow-sm" placeholder="Harcama Başlığı" 
            value={title} onChange={(e) => setTitle(e.target.value)}
          />
        </div>
        <div className="row g-2 mb-3">
          <div className="col-8">
            <input 
              type="number" className="form-control shadow-sm" placeholder="Miktar" 
              value={amount} onChange={(e) => setAmount(e.target.value)}
            />
          </div>
          <div className="col-4">
            <select className="form-select shadow-sm" value={currency} onChange={(e) => setCurrency(e.target.value)}>
              <option value="MKD">MKD</option>
              <option value="EUR">EUR</option>
              <option value="USD">USD</option>
              <option value="TRY">TRY</option>
            </select>
          </div>
        </div>
        <div className="mb-3">
          <select className="form-select shadow-sm" value={category} onChange={(e) => setCategory(e.target.value)}>
            <option value="Yemek">Yemek 🍔</option>
            <option value="Ulaşım">Ulaşım 🚌</option>
            <option value="Konaklama">Konaklama 🏨</option>
            <option value="Diğer">Diğer 🎁</option>
          </select>
        </div>
        <button type="submit" className={`btn w-100 fw-bold shadow-sm ${editData ? 'btn-warning' : 'btn-success'}`}>
          {editData ? 'Değişiklikleri Kaydet' : 'Listeye Ekle'}
        </button>
      </form>
    </div>
  );
}

export default ExpenseForm;