import Vue from 'vue';
import Vuex from 'vuex';
import * as types from './mutation-types';
import axios from './axios';
import vueSession from 'vue-session';


Vue.use(Vuex);
const debug = process.env.NODE_ENV !== 'production';
const API_URL = process.env.ROOT_API;

const mutations = {
  setPosts(state, payload) {
    state.posts = payload;
  },
  user(state, value) {
    state.user = value;
  },
  auth(state, value) {
    state.auth = value;
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
  async login({state, commit}) {
    try {
      let response = await axios.post(`${API_URL}/login`, {user: state.user});
      commit('auth', response.data);
    } catch(error) {
      console.log(error);
    }
    
    
  }
};



const getters = {
  user: state => state.user,
  auth: state => state.auth
};

const state = {
  accessToken: '',
  posts: [],
  added: [],
  all: [],
  user: null,
  auth: {},
  postsApiUrl: `${process.env.ROOT_API}/api/v1/posts`
};

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});