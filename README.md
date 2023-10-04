# expense_tracker_app

Flutter project for the first assignment in IDATA2503 Mobile Application 2023.

## Specifications

The list of Specifications is taken from the the current assignment found [here](https://docs.google.com/document/d/1NN_8vQoxLk_hnm8AVWTyfnkeDqMhBqonc5t1VH394lU/edit)

I believe the application is meeting every specification as of date 04.10.2023 within the specifications 1-13.

The points 14 and is further requirements given within the assignment for documentation which will be given in this file

## User Story

Since this application is mostly written using a tutorial given within a Udemy course, I would intemperate it as writing a user story for the feature specified in point 12. My reason being that this is the feature I have planned and implemented, and therefore have sufficient background info about the thinking method to argument for the method of implementation.

### As a person I want to be able to change my finances so I can edit it in case of mistyping or wrong categorizing

This can be done trough modifying the new_expense to [expenseMenu](./lib/widgets/expenseMenu.dart).
The changes includes allowing the menu to accept a expense so we know if we are modifying or it is a new one. The reason we are changing the class instead of implementing a new one, is because the widget already meets our requirements for attributes in the expense to be changed .

We also need to allow the user access to this feature so we are adding a functionality to list to allow users to tap it for editing it. This requires we modify both expenses, expensesList and expensesItem to pass down a openEditing function.

## File Structure

### [lib](./lib/)

The root folder of the code

- [main.dart](./lib/main.dart) The main application file

#### [models](./lib/models/)

This folder contains everything that has data models within it such as:

- [expense](./lib/models/expense.dart) that represents a expense in data form

#### [widgets](./lib/widgets/)

This folder contains everything that has widget (visualization of data) within it

- [expenseMenu.dart](./lib/widgets/expenseMenu.dart) used for showing a page to edit or adding new expense
- [expenses.dart](./lib/widgets/expenses.dart) used as a page to visualize information about the expenses
- [chart](./lib/widgets/chart/) containing everything to visualize the expenses as a data chart.
  - [chart.dart](./lib/widgets/chart/chart.dart) visualizes the chart
  - [chart_bar.dart](./lib/widgets/chart/chart_bar.dart) visualizes a bar within the chart. One bar represents one category.
- [expenses_list](./lib/widgets/expenses_list/) Containing everything needed to visualizing a list of expenses
  - [expense_item.dart](./lib/widgets/expenses_list/expense_item.dart) Each individual item within the list
  - [expense_list.dart](./lib/widgets/expenses_list/expenses_list.dart) is a parent widget to contain every expense_item in a orderly fashion

## App architecture Diagram

```mermaid
stateDiagram-v2
s1 : UI Layer 
state s1 {
    ui1 : Chart
    --ui2 : ChartBar
    --ui3 : ExpensesList
    --ui4 : ExpenseItem
    --ui5 : ExpenseMenu
    ui6 : _ExpenseMenuState
    ui5 --> ui6
    --ui7 : Expenses 
    ui8 : _ExpensesState
    ui7 --> ui8
}
s2 : Data models
state s2 {
    data1 : Category
    --data2 : Buckets
    --data3 : Expense
    }
s1 --> s2

```

## Class Diagram

Auto generated trough the package flutters dcdg package:

```mermaid
classDiagram
class Expense
Expense : +id String
Expense : +title String
Expense : +amount double
Expense : +date DateTime
Expense : +category Category
Expense o-- Category
Expense : +formattedDate String

class ExpenseBucket
ExpenseBucket : +category Category
ExpenseBucket o-- Category
ExpenseBucket : +expenses List~Expense~
ExpenseBucket : +totalExpenses double

class Category
<<enumeration>> Category
Category : +index int
Category : +values$ List~Category~
Category : +food$ Category

class Chart
Chart : +expenses List~Expense~
Chart : +buckets List~ExpenseBucket~
Chart : +maxTotalExpense double
Chart : +build() Widget
StatelessWidget <|-- Chart

class ChartBar
ChartBar : +fill double
ChartBar : +build() Widget
StatelessWidget <|-- ChartBar

class ExpenseMenu
ExpenseMenu : +onFinishedExpense void FunctionExpense
ExpenseMenu : +itemToEdit Expense?
ExpenseMenu o-- Expense
ExpenseMenu : +createState() State<ExpenseMenu>
StatefulWidget <|-- ExpenseMenu

class _ExpenseMenuState
_ExpenseMenuState : -_titleController TextEditingController
_ExpenseMenuState : -_amountController TextEditingController
_ExpenseMenuState : -_selectedDate DateTime?
_ExpenseMenuState : -_selectedCategory Category
_ExpenseMenuState o-- Category
_ExpenseMenuState : +initState() void
_ExpenseMenuState : -_presentDatePicker() void
_ExpenseMenuState : -_submitExpenseData() void
_ExpenseMenuState : +dispose() void
_ExpenseMenuState : +build() Widget
State <|-- _ExpenseMenuState

class Expenses
Expenses : +createState() State<Expenses>
StatefulWidget <|-- Expenses

class _ExpensesState
_ExpensesState : -_registeredExpenses List~Expense~
_ExpensesState : -_openAddExpenseOverlay() void
_ExpensesState : -_addExpense() void
_ExpensesState : -_removeExpense() void
_ExpensesState : -_openEditExpenseOverlay() void
_ExpensesState : -_editExpense() void
_ExpensesState : +build() Widget
State <|-- _ExpensesState

class ExpensesList
ExpensesList : +expenses List~Expense~
ExpensesList : +onRemoveExpense void FunctionExpense
ExpensesList : +onEditExpense void FunctionExpense
ExpensesList : +build() Widget
StatelessWidget <|-- ExpensesList

class ExpenseItem
ExpenseItem : +expense Expense
ExpenseItem o-- Expense
ExpenseItem : +build() Widget
StatelessWidget <|-- ExpenseItem
```
