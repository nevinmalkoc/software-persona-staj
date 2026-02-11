import React, { useState, useEffect } from 'react';
import ExpenseForm from './Components/ExpenseForm';
import './App.css';

function App() {
  const [expenses, setExpenses] = useState(() => {
    const saved = localStorage.getItem('expenses');
    return saved ? JSON.parse(saved) : [];
  });
  
  const [destination, setDestination] = useState('Makedonya');
  const [editingExpense, setEditingExpense] = useState(null);

  useEffect(() => {
    localStorage.setItem('expenses', JSON.stringify(expenses));
  }, [expenses]);

  const addOrUpdateExpense = (expenseData) => {
    if (editingExpense) {
      const updated = expenses.map(item => 
        item.id === editingExpense.id ? { ...expenseData, id: item.id } : item
      );
      setExpenses(updated);
      setEditingExpense(null);
    } else {
      setExpenses([...expenses, { ...expenseData, id: Date.now() }]);
    }
  };

  const deleteExpense = (id) => {
    setExpenses(expenses.filter(item => item.id !== id));
  };

  const clearAllExpenses = () => {
    if (window.confirm("Tüm gezi verilerini sıfırlamak istediğine emin misin?")) {
      setExpenses([]);
      localStorage.removeItem('expenses');
    }
  };

  const calculateTotals = () => {
    const totals = { MKD: 0, EUR: 0, TRY: 0, USD: 0 };
    expenses.forEach(item => {
      if (totals[item.currency] !== undefined) {
        totals[item.currency] += item.amount;
      }
    });
    return totals;
  };

  const totals = calculateTotals();

  return (
    <div className="app-wrapper">
      <div className="main-container">
        <div className="text-center mb-5">
          <h1 className="fw-bold display-4 text-dark">✈️ {destination} Bütçem</h1>
          <input 
            type="text" 
            className="form-control form-control-sm text-center mx-auto mt-2 border-primary rounded-pill shadow-sm"
            style={{ maxWidth: '250px' }}
            value={destination}
            onChange={(e) => setDestination(e.target.value)}
          />
        </div>

        <div className="custom-card card p-2 mb-4">
          <ExpenseForm onAddExpense={addOrUpdateExpense} editData={editingExpense} />
        </div>

        {expenses.length > 0 && (
          <div className="card bg-dark text-white custom-card mb-4 p-4 shadow-lg">
            <h5 className="text-info border-bottom border-secondary pb-2 mb-3 fw-bold">
              💰 Toplam Harcama Özeti
            </h5>
            <div className="row text-center">
              <div className="col-3">
                <small className="d-block text-muted mb-1">Dinar</small>
                <div className="fw-bold text-primary fs-5">{totals.MKD.toLocaleString()} MKD</div>
              </div>
              <div className="col-3">
                <small className="d-block text-muted mb-1">Euro</small>
                <div className="fw-bold text-warning fs-5">{totals.EUR.toLocaleString()} €</div>
              </div>
              <div className="col-3">
                <small className="d-block text-muted mb-1">Dolar</small>
                <div className="fw-bold text-success fs-5">{totals.USD.toLocaleString()} $</div>
              </div>
              <div className="col-3">
                <small className="d-block text-muted mb-1">TL</small>
                <div className="fw-bold text-danger fs-5">{totals.TRY.toLocaleString()} ₺</div>
              </div>
            </div>
          </div>
        )}

        <div className="bg-white custom-card card p-4 mb-5 shadow-sm">
          <h5 className="d-flex justify-content-between align-items-center mb-4 text-secondary border-bottom pb-2">
            <span>Harcama Geçmişi</span>
            <div>
              <span className="badge bg-primary rounded-pill px-3 me-2">{expenses.length} Kayıt</span>
              {expenses.length > 0 && (
                <button onClick={clearAllExpenses} className="btn btn-outline-danger btn-sm rounded-pill px-3 fw-bold">
                  🗑️ Tümünü Temizle
                </button>
              )}
            </div>
          </h5>
          <div className="list-group list-group-flush">
            {expenses.length === 0 ? (
              <p className="text-center text-muted py-4">Henüz bir harcama eklenmedi.</p>
            ) : (
              expenses.map((item) => (
                <div key={item.id} className="list-group-item d-flex justify-content-between align-items-center py-3">
                  <div className="d-flex align-items-center">
                    <button onClick={() => deleteExpense(item.id)} className="btn btn-outline-danger btn-sm border-0 me-2 rounded-circle">✕</button>
                    <button onClick={() => { setEditingExpense(item); window.scrollTo({ top: 0, behavior: 'smooth' }); }} className="btn btn-outline-primary btn-sm border-0 me-3 rounded-circle">✎</button>
                    <div>
                      <span className="fw-bold d-block text-dark">{item.title}</span>
                      <small className="text-muted">{item.category}</small>
                    </div>
                  </div>
                  <span className={`badge px-3 py-2 rounded-pill shadow-sm ${
                    item.currency === 'MKD' ? 'bg-primary' : 
                    item.currency === 'EUR' ? 'bg-warning text-dark' : 
                    item.currency === 'USD' ? 'bg-success' : 'bg-danger'
                  }`}>
                    {item.amount.toLocaleString()} {item.currency}
                  </span>
                </div>
              ))
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;