import api from './baseService';
import { AxiosResponse } from 'axios';

interface LoginData {
  email: string;
  password: string;
}

interface RegisterData {
  email: string;
  password: string;
  name: string;
  [key: string]: unknown;
}

export class AuthService {
  async login(data: LoginData): Promise<AxiosResponse> {
    try {
      const response = await api.post('/auth/login', data);
      this.setToken(response.data.token);
      return response;
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  async register(data: RegisterData): Promise<AxiosResponse> {
    try {
      const response = await api.post('/auth/register', data);
      this.setToken(response.data.token);
      return response;
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  async logout(): Promise<void> {
    try {
      await api.post('/auth/logout');
      this.clearToken();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  setToken(token: string): void {
    localStorage.setItem('token', token);
  }

  clearToken(): void {
    localStorage.removeItem('token');
  }

  getToken(): string | null {
    return localStorage.getItem('token');
  }

  isAuthenticated(): boolean {
    return !!this.getToken();
  }
}
