import { BrowserRouter, Routes, Route } from "react-router-dom"
import Register from "@/pages/Register";
import Login from "@/pages/Login";
import AuthLayout from "@/components/layout/AuthLayout";
import AppLayout from "./components/layout/AppLayout";
import Dashboard from "./pages/Dashboard";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={
          <AppLayout>
            <Dashboard />
          </AppLayout>
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
