import { AUTH_PATH } from '@/utils/path';
import { AxiosResponse } from 'axios';
import api from './baseService';

export interface LoginData {
  email: string;
  password: string;
}

export interface RegisterData {
  email: string;
  password: string;
  username: string;
  [key: string]: unknown;
}

export class AuthService {
  async login(data: LoginData): Promise<AxiosResponse> {
    const response = await api.post(AUTH_PATH.LOGIN, { user: data });

    const token = this.extractToken(response.headers.authorization);
    if (token) {
      this.setCurrentUser(token, response.data.user.email, response.data.user.username);
    }

    return response;
  }

  async register(data: RegisterData): Promise<AxiosResponse> {
    const response = await api.post(AUTH_PATH.REGISTER, { user: data });

    const token = this.extractToken(response.headers.authorization);
    if (token) {
      this.setCurrentUser(token, response.data.user.email, response.data.user.username);
    }

    return response;
  }

  async logout(): Promise<void> {
    try {
      await api.delete(AUTH_PATH.LOGOUT);
      this.clearStorage();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }

  setCurrentUser(token: string, email: string, username: string): void {
    localStorage.setItem('token', token);
    localStorage.setItem('email', email);
    localStorage.setItem('username', username);
    localStorage.setItem('isAuthenticated', 'true')
  }

  clearStorage(): void {
    localStorage.clear();
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
