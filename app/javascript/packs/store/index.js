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
  login(state, value) {
    state.auth_token = value;
    state.authenticated = true;
  },
  auth(state, value) {
    state.auth = value;
  },
  getErrors(state, value) {
    state.errors = value
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
  async authenticate({commit}, auth_token) {
    commit('auth', auth_token);
  },
  async login({commit}, user) {
    try {
      console.log(user)
      let response = await axios.post(`${API_URL}/login`, user);
      console.log(response.data);
      if (response.status === 201)
      { 
        commit('login', response.data);
        localStorage.setItem('auth_token', response.data);

        // this.axios.defaults.headers.common['Authorization'] = response.data;
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
  errors: state => state.errors

};

const state = {
  accessToken: '',
  posts: [],
  added: [],
  all: [],
  user: {},
  auth: {},
  errors: null,
  auth_token: null,
  authenticated: false,
  postsApiUrl: `${process.env.ROOT_API}/api/v1/posts`
};

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});