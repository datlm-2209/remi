import { create } from 'zustand';
import { authService } from '@/services';
import { LoginData, RegisterData } from '@/services/authService';
import { AxiosError } from 'axios';

interface AuthState {
  isAuthenticated: boolean;
  user: Record<string, unknown> | null;
  error: string | null;
  login: (data: LoginData) => Promise<void>;
  register: (data: RegisterData) => Promise<void>;
  logout: () => Promise<void>;
}

const useAuthStore = create<AuthState>((set) => ({
  isAuthenticated: false,
  user: null,
  error: null,

  login: async (data: LoginData) => {
    try {
      const response = await authService.login(data);
      set({ isAuthenticated: true, user: response.data.user, error: null  });
      window.location.href = '/'
    } catch(error) {
      if (error instanceof AxiosError && error.response) {
        set({ error: error.response.data});
      } else {
        set({error: "Login Failed!"})
      }
    }
  },

  register: async (data: RegisterData) => {
    try {
      const response = await authService.register(data);
      set({ isAuthenticated: true, user: response.data.user, error: null });
      window.location.href = '/'
    } catch(error) {
      if (error instanceof AxiosError && error.response) {
        set({ error: error.response.data.status.message || "Unexpected error occurred!"});
      } else {
        set({error: "Registration Failed!"})
      }
    }
  },

  logout: async () => {
    try {
      await authService.logout();
      set({ isAuthenticated: false, user: null });
      window.location.href = '/'
    } catch (error) {
      console.error('Logout failed:', error);
      throw error;
    }
  },
}));

export default useAuthStore;
