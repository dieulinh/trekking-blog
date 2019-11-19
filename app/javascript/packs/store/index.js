import Vue from 'vue';
import Vuex from 'vuex';
import * as types from './mutation-types';
import axios from 'axios';

Vue.use(Vuex);
const debug = process.env.NODE_ENV !== 'production';
const API_URL = process.env.ROOT_API;

const mutations = {
  setPosts(state, payload) {
    state.posts = payload;
  },
  logout(state) {
    state.authenticated = false;
  },
  login(state, value) {
    state.auth_token = value;
    state.authenticated = true;
  },
  auth(state, value) {
    state.auth = value;
  },
  getErrors(state, value) {
    state.errors = value
  },
  showLogin(state, value) {
    state.showLogin = value;
  },
  showRegisterForm(state, visible) {
    state.showRegisterForm = visible;
  },
  registerUser(state, user) {
    state.user = user
  }
};

const actions = {
  async getPosts({ state, commit }) {
    try {
      let response = await axios.get(`${state.postsApiUrl}`, {
          params: {
              
          }
      });
        commit('setPosts', response.data);
    } catch (error) {
      commit('setPosts', []);
    }
  },
  setError({commit}, errors) {
    commit('getErrors', errors);
  },
  logout({commit}) {
    localStorage.removeItem('auth_token');
    commit('logout');
  },
  showRegisterForm({commit}, showRegister) {
    commit('showRegisterForm', showRegister);
  },
  showLogin({commit}, showValue) {
    commit('showLogin', showValue);
  },
  async createUser({commit}, user) {
    try {
      console.log(user);
      let response = await axios.post(`${process.env.ROOT_API}/login/register`, user );
      console.log(response);
      if (response.status === 201)
      { 
        console.log(response.data)
        commit('registerUser', response.data)
      } else {
        console.log(response);
        commit('getErrors', response.data);
      }
    } catch(error) {
      console.log(error);
      commit('getErrors', error);
    }
  },
  async authenticate({commit}, auth_token) {
    commit('auth', auth_token);
  },
  async login({commit}, user) {
    try {
      let response = await axios.post(`${API_URL}/login`, user);
      if (response.status === 201)
      { 
        commit('login', response.data);
        localStorage.setItem('auth_token', response.data);
      } else {
        commit('getErrors', response.data);
      }
    } catch(error) 
    {
      console.log(error.response);
      commit('getErrors', error.response.data);
    }
    
  }
};

const getters = {
  user: state => state.user,
  auth_token: state => state.auth_token,
  authenticated: state => state.authenticated,
  errors: state => state.errors,
  showLogin: state => state.showLogin,
  showRegisterForm: state => state.showRegisterForm
};

const state = {
  accessToken: '',
  posts: [],
  showLogin: false,
  showRegisterForm: false,
  added: [],
  all: [],
  user: null,
  auth: {},
  errors: null,
  auth_token: null,
  authenticated: !!localStorage.getItem('auth_token'),
  postsApiUrl: `${process.env.ROOT_API}/api/v1/posts`
};

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});