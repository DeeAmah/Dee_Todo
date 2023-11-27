// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TodoList {
    // Struct to represent a Todo item
    struct Todo {
        string taskTitle;
        string taskDescription;
        bool isCompleted;
        address taskCreator;
    }

    // Array to store all Todo items
    Todo[] public tasks;

    // Mapping to keep track of the creator of each todo
    mapping(address => uint256) public taskCreators;

    // Function to create a new Todo
    function createTask(string memory _title, string memory _description) public {
        Todo memory newTask = Todo({
            taskTitle: _title,
            taskDescription: _description,
            isCompleted: false,
            taskCreator: msg.sender
        });
        
        tasks.push(newTask);
        uint256 index = tasks.length - 1;
        taskCreators[msg.sender] = index;
    }

    // Function to get details of a Todo
    function getTaskDetails(uint256 _index) public view returns (string memory, string memory, bool, address) {
        require(_index < tasks.length, "Task index out of bounds");

        Todo storage task = tasks[_index];
        return (task.taskTitle, task.taskDescription, task.isCompleted, task.taskCreator);
    }

    // Function to mark a Todo as done
    function markTaskAsDone(uint256 _index) public {
        require(_index < tasks.length, "Task index out of bounds");
        require(taskCreators[_index] == msg.sender, "Only the creator can mark the Task as done");

        tasks[_index].isCompleted = true;
    }
}
