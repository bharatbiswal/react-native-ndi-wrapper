import React, { Component } from 'react';
import {
  StyleSheet, View, Button, TouchableOpacity, Text,
  FlatList, Dimensions, Alert
} from 'react-native';
import { ScrollView } from 'react-native-gesture-handler';


import NdiWrapper from 'react-native-ndi-wrapper';
let thisInstance = null;
export default class FirstScreen extends Component {
  constructor(props) {
    super(props);

    thisInstance = this;
    this.state = {
      senders: [],
      scanning: false,
    };

  }

  static navigationOptions = {
    title: 'First Page',
    headerStyle: {
      backgroundColor: '#3b5998',
    },
    headerTintColor: '#fff',
    headerTitleStyle: {
      fontWeight: 'bold',
    },
  };

  findSendersClicked = () => {
    if (this.state.scanning == true) { return; }

    this.setState({ scanning: true });
    NdiWrapper.findSources()
      .then((sources) => {

        if ((sources == undefined) || (sources.length < 1)) {
          Alert.alert(
            "No Sources found",
            "Scanning did not find any video sources in the LAN. Please try again later.",
            [
              { text: "Close", onPress: () => { }, style: 'cancel' },
            ],
            { cancelable: false }
          );
        } else {
          thisInstance.setState({ senders: sources });
        }
        thisInstance.setState({ scanning: false });
      })
      .catch((err) => {

        Alert.alert(
          "Scanning Error",
          err.message,
          [
            { text: "Close", onPress: () => { }, style: 'cancel' },
          ],
          { cancelable: false }
        );
        thisInstance.setState({ scanning: false });
      });

  }


  render() {
    const { navigate } = this.props.navigation;
    return (
      <View style={styles.container}>
        {/* <TouchableOpacity
          style={styles.buttonStyle}
          onPress={() => navigate('SecondScreen')}
          activeOpacity={0.7}
        >
          <Text style={styles.btntext}> Go </Text>
        </TouchableOpacity> */}

        <View style={styles.listviewStyle}>
          <ScrollView>
            <FlatList
              keyExtractor={(item, index) => index.toString()}
              data={this.state.senders}
              renderItem={({ item }) => (
                <View style={styles.flatListStyle}>
                  <View style={styles.listStyle}>
                    <Text style={styles.titleStyle}>{item.p_ndi_name}</Text>
                    {(item.p_ip_address != undefined) &&
                      <Text style={styles.subtitleStyle} note>{item.p_ip_address} </Text>
                    }
                    {(item.p_url_address != undefined) &&
                      <Text style={styles.subtitleStyle} note>{item.p_url_address} </Text>
                    }
                  </View>
                </View>
              )}
            />
          </ScrollView>
        </View>
        <View style={styles.btnviewStyle}>
          {(this.state.scanning == false) &&
            <TouchableOpacity
              style={styles.buttonStyle}
              onPress={() => { this.findSendersClicked(); }}
              activeOpacity={0.7}
            >
              <Text style={styles.btntext}> Find Senders </Text>
            </TouchableOpacity>
          }
          {(this.state.scanning == true) &&
            <TouchableOpacity
              style={styles.buttonStyle}
              onPress={() => { }}
              activeOpacity={0.7}
            >
              <Text style={styles.btntext}> Scanning ... </Text>
            </TouchableOpacity>
          }
        </View>
      </View>
    );
  }
}
const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  buttonStyle: {
    backgroundColor: '#3b5998',
    padding: 10,
    paddingRight: 20,
    paddingLeft: 20,
    borderRadius: 5
  },
  btntext: {
    color: '#fff',
    fontSize: 18
  },
  listviewStyle: {
    flex: 1,
    backgroundColor: '#fff',
    width: Dimensions.get('window').width
  },
  btnviewStyle: {
    flex: 1,
    backgroundColor: '#efefef',
    justifyContent: 'center',
    flexDirection: 'row',
    alignItems: 'center',
    width: Dimensions.get('window').width
  },
  listStyle: {
    borderBottomWidth: 1,
    borderBottomColor: '#ccc',
    padding: 10,
    // paddingBottom:8,
    // paddingTop:8

  },
  titleStyle: {
    fontSize: 18,
    fontWeight: "bold",
    marginBottom: 4
  },
  subtitleStyle: {
    fontSize: 16,
  }
});