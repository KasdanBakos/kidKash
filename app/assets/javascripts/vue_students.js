function run_ajax2(method, data, link, callback=function(res){students.get_students()}){
  $.ajax({
    method: method,
    data: data,
    url: link,
    success: function(res) {
      students.errors = {};
      callback(res);
    },
    error: function(res) {
      console.log("error");
      students.errors = res.responseJSON;
    }
  })
}



// A component describing a row in the students table
Vue.component('student-row', {
  // Defining where to look for the HTML template in the index view
  template: `#student-row`,

  // Passed elements to the component from the Vue instance
  props: {
    student: Object
  },

  data: function () {
    return {
      camp_id: 0
    }
  },


  created() {
    this.camp_id = $('#camp_id').val();
  },  

  // Behaviors associated with this component
  methods: {
    remove_record2: function(student){
      run_ajax2('DELETE', {student: student}, '/camps/'.concat(this.camp_id, '/students/',student['id'],'.json'));
    }
  }
});





var new_form = Vue.component('new-registration-form', {
  template: '#registration-form-template',

  mounted() {
    // need to reconnect the materialize select javascript 
    $('#registration_student_id').material_select()
  },

  data: function () {
    return {
        camp_id: 0,
        student_id: 0,
        errors: {}
    }
  },

  methods: {
    submitForm: function (x) {
      // let camp_id = $("#camp_id").val();
      new_post = {
        camp_id: this.camp_id,
        student_id: this.student_id
      }
      run_ajax2('POST', {student: new_post}, '/camps/'+camp_id+'/students/'+this.student_id+'.json')
      students.switch_modal()
    }
  },
})





//Code to instantiate a blank, new instance of Vue.JS
var students = new Vue({
  el: '#assignments2',
  // within the code to define the instance of Vue assigned to the variable students
  data: {
    camp_id: 0,
    students: [],
    modal_open: false,
    errors: {}
  },

  created() {
    this.camp_id = $('#camp_id').val();
  },

  methods: {
    switch_modal: function(event){
      this.modal_open = !(this.modal_open);
    },

    get_students: function(){
      run_ajax2('GET', {}, '/camps/'.concat(this.camp_id, '/students.json'), function(res){students.students = res});
    }
  },
  mounted: function(){
    this.get_students();
  }



});