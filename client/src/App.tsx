import { BrowserRouter, Routes, Route } from "react-router-dom"
import Register from "@/pages/Register";
import Login from "@/pages/Login";
import AuthLayout from "@/components/layout/AuthLayout";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={
          <h1>DASHBOARD</h1>
        } />
        <Route path="/login" element={
          <AuthLayout>
            <Login />
          </AuthLayout>
        } />
        <Route path="/register" element={
          <AuthLayout>
            <Register />
          </AuthLayout>
        } />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
