const START_ROW_WINNERS = 11;
const ss = SpreadsheetApp.getActiveSheet();
const TOTAL_NUMBER_TO_SELECT = Number(ss.getRange(3,8).getValues()[0][0]);

function onOpen() {
  var spreadsheet = SpreadsheetApp.getActive();
  var menuItems = [
    {name: 'Select Random winners', functionName: 'selectRandomWinners'},
    {name: 'Reset', functionName: 'resetWinners'}
  ];
  spreadsheet.addMenu('Lottery', menuItems);
}

function getRandomInt(min, max) {
  let numbers = [];
  for (;;) {
    var n = Math.floor(Math.random() * (max - min + 1)) + min;
    if (!numbers.includes(n)) numbers.push(n);
    if (numbers.length == TOTAL_NUMBER_TO_SELECT) break;
  }
  return numbers;
}

function selectRandomWinners() {

  var selectedWinners = getRandomInt(2,ss.getDataRange().getValues().length);
  for (index=0; index<selectedWinners.length; index++) {
    console.log(selectedWinners);
    ss.getRange(selectedWinners[index],2).setBackground("yellow");
    ss.getRange(START_ROW_WINNERS + Number(index),7).setValue(ss.getRange(selectedWinners[index],2).getValue());
    ss.getRange(START_ROW_WINNERS + Number(index),8).setValue(ss.getRange(selectedWinners[index],3).getValue());
    ss.getRange(START_ROW_WINNERS + Number(index),9).setValue(index+1);
  }
}

function resetWinners() {
  ss.getRange(2,2,ss.getDataRange().getValues().length).setBackground('white');
  ss.getRange(START_ROW_WINNERS,7,START_ROW_WINNERS + TOTAL_NUMBER_TO_SELECT,3).setValue("");
}

function test() {
   const ss = SpreadsheetApp.getActiveSheet();
   console.log(ss.getDataRange().getValues().length);
   ss.getRange(2,2,ss.getDataRange().getValues().length).setBackground('white');
}



