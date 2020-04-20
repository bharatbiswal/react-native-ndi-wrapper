import React, { Component } from 'react';
import { StyleSheet, View, Text} from 'react-native';

export default class SecondScreen extends Component {
    static navigationOptions = {
        title: 'Second Page',
        headerStyle: {
          backgroundColor: '#3b5998',
        },
        headerTintColor: '#fff',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
    };

  render() {
    const { navigate } = this.props.navigation;
    return (
      <View style={styles.container}>
        <Text>You are on SecondPage</Text>
      </View>
    );
  }
}
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    // margin:50,
    alignItems: 'center',
    justifyContent: 'center',
  },
});