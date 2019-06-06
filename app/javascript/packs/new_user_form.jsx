class PostForm extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        username: props.user.username,
        first_name: props.user.first_name,
        last_name: props.user.last_name,
        email: props.user.last_name,
        password: props.user.password,
        password_confirmation: props.user.password_confirmation,
        role: props.user.role
      };
      
    //   this.handleChange = this.handleChange.bind(this);
  
  
        // this.handleTitleChange = this.handleTitleChange.bind(this);
        // this.handleContentChange = this.handleContentChange.bind(this);
    }
  
    // handleChange(e){
    //   this.setState({[e.target.id]: e.target.value});
    // }
    
    render(){
      return(
        <div>
          <h3>Form!!</h3>
        </div>
      )
    }
  
  }

  export default new PostForm;