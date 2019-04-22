import Vue from 'vue';
import Vuex from 'vuex';
import * as types from './mutation-types';
import axios from './axios';


Vue.use(Vuex);
const debug = process.env.NODE_ENV !== 'production';

const mutations = {
  [types.ADD_TO_CART] (state, {id}) {
    const record = state.added.find(p => p.id === id)
    if (!record) {
      state.added.push({
        id,
        quantity: 1
      })
    } else {
      record.quantity++;
    }
  },
  setPosts(state, payload) {
    state.posts = payload;
  }
};

const actions = {
  addToCart({commit}, product) {
    commit(types.ADD_TO_CART, {id: product.id})
  },
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
}
};

const getters = {

};

const state = {
  posts: [],
  added: [],
  all: [],
  postsApiUrl: 'localhost:3000/api/v1/posts'
};

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});