import { AuthPath } from '@/utils/path';
import { AxiosResponse } from 'axios';
import api from './baseService';

export interface LoginData {
  email: string;
  password: string;
}

export interface RegisterData {
  email: string;
  password: string;
  name: string;
  [key: string]: unknown;
}

export class AuthService {
  async login(data: LoginData): Promise<AxiosResponse> {
    const response = await api.post(AuthPath.LOGIN, { user: data });

    const token = this.extractToken(response.headers.authorization);
    if (token) {
      this.setCurrentUser(token, response.data.data.user.email, response.data.data.user.name);
    }

    return response;
  }

  async register(data: RegisterData): Promise<AxiosResponse> {
    const response = await api.post(AuthPath.REGISTER, { user: data });

    const token = this.extractToken(response.headers.authorization);
    if (token) {
      this.setCurrentUser(token, response.data.data.user.email, response.data.data.user.name);
    }

    return response;
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

  setCurrentUser(token: string, email: string, name: string): void {
    localStorage.setItem('token', token);
    localStorage.setItem('email', email);
    localStorage.setItem('name', name);
    localStorage.setItem('loggedIn', 'true')
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

  extractToken(authHeader: string | undefined): string | null {
    if (authHeader) {
      return authHeader.replace('Bearer ', '');
    }
    return null;
  };
}
