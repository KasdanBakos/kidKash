import Button from "@material-ui/core/Button";

class HelloWorld extends React.Component {
  render() {
    return (
      <React.Fragment>
        Greeting: {this.props.name}
        <Button></Button>
      </React.Fragment>
    );
  }
};

