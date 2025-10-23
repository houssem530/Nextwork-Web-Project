<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Advanced To-Do List</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3a0ca3;
            --success: #4cc9f0;
            --danger: #f72585;
            --warning: #fca311;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --card-shadow: 0 10px 20px rgba(0, 0, 0, 0.12), 0 4px 8px rgba(0, 0, 0, 0.06);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: var(--dark);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            width: 100%;
            max-width: 900px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
            margin: 20px;
        }

        header {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            padding: 25px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        header p {
            font-size: 1.1rem;
            opacity: 0.9;
        }

        header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
            transform: rotate(30deg);
        }

        .app-content {
            display: flex;
            flex-direction: column;
            padding: 0;
        }

        @media (min-width: 768px) {
            .app-content {
                flex-direction: row;
            }
        }

        .task-form-section {
            padding: 25px;
            background: white;
            flex: 1;
        }

        @media (min-width: 768px) {
            .task-form-section {
                border-right: 1px solid #eee;
                max-width: 350px;
            }
        }

        .tasks-section {
            padding: 25px;
            background: #f9fafb;
            flex: 2;
            min-height: 500px;
        }

        .section-title {
            color: var(--primary);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #eee;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title i {
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-control {
            width: 100%;
            padding: 14px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.15);
        }

        textarea.form-control {
            min-height: 100px;
            resize: vertical;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 20px;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.25);
        }

        .btn-secondary {
            background: var(--gray);
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            background: #e30c74;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(247, 37, 133, 0.25);
        }

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-success:hover {
            background: #3bb4d8;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(76, 201, 240, 0.25);
        }

        .btn-warning {
            background: var(--warning);
            color: white;
        }

        .btn-warning:hover {
            background: #e59400;
            transform: translateY(-2px);
        }

        .loading {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            margin-bottom: 20px;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 4px solid #e2e8f0;
            border-top: 4px solid var(--primary);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 20px;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .error-message {
            background-color: #ffeaea;
            color: #d32f2f;
            padding: 16px;
            border-radius: 12px;
            margin-bottom: 20px;
            border-left: 4px solid #d32f2f;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .tasks-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
        }

        @media (min-width: 576px) {
            .tasks-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (min-width: 992px) {
            .tasks-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        .task-card {
            background: white;
            padding: 20px;
            border-radius: 16px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: var(--transition);
            border-left: 5px solid var(--primary);
            position: relative;
            overflow: hidden;
        }

        .task-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--card-shadow);
        }

        .task-card.completed {
            border-left-color: var(--success);
            opacity: 0.85;
        }

        .task-card.completed::after {
            content: 'COMPLETED';
            position: absolute;
            top: 10px;
            right: -30px;
            background: var(--success);
            color: white;
            font-size: 0.7rem;
            font-weight: bold;
            padding: 5px 30px;
            transform: rotate(45deg);
        }

        .task-card h3 {
            color: var(--dark);
            margin-bottom: 12px;
            font-size: 1.25rem;
            padding-right: 30px;
        }

        .task-card p {
            color: var(--gray);
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .task-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            font-size: 0.85rem;
        }

        .task-status {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #fff0c7;
            color: #b38700;
        }

        .status-completed {
            background-color: #d1f7ea;
            color: #0c9770;
        }

        .task-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .task-actions .btn {
            padding: 8px 14px;
            font-size: 0.9rem;
            flex: 1;
            justify-content: center;
        }

        .no-tasks {
            text-align: center;
            padding: 40px;
            color: var(--gray);
            grid-column: 1 / -1;
        }

        .no-tasks i {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #cbd5e0;
        }

        .no-tasks h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: var(--dark);
        }

        .stats-bar {
            display: flex;
            justify-content: space-between;
            background: white;
            padding: 15px 25px;
            border-bottom: 1px solid #eee;
        }

        .stat {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
        }

        .stat-label {
            font-size: 0.85rem;
            color: var(--gray);
        }

        .toast {
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: white;
            color: var(--dark);
            padding: 16px 24px;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            display: flex;
            align-items: center;
            gap: 12px;
            transform: translateY(100px);
            opacity: 0;
            transition: var(--transition);
            z-index: 1000;
        }

        .toast.show {
            transform: translateY(0);
            opacity: 1;
        }

        .toast.success {
            border-left: 4px solid var(--success);
        }

        .toast.error {
            border-left: 4px solid var(--danger);
        }

        .toast i {
            font-size: 1.5rem;
            color: var(--success);
        }

        .toast.error i {
            color: var(--danger);
        }

        .filter-options {
            display: flex;
            gap: 12px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 8px 16px;
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
        }

        .filter-btn.active {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .task-date {
            color: var(--gray);
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1><i class="fas fa-tasks"></i> Advanced To-Do List</h1>
            <p>Stay organized and boost your productivity</p>
        </header>

        <div class="stats-bar">
            <div class="stat">
                <span class="stat-value" id="totalTasks">0</span>
                <span class="stat-label">Total Tasks</span>
            </div>
            <div class="stat">
                <span class="stat-value" id="completedTasks">0</span>
                <span class="stat-label">Completed</span>
            </div>
            <div class="stat">
                <span class="stat-value" id="pendingTasks">0</span>
                <span class="stat-label">Pending</span>
            </div>
        </div>

        <div class="app-content">
            <!-- Task Form Section -->
            <section class="task-form-section">
                <h2 class="section-title"><i class="fas fa-plus-circle"></i> Add New Task</h2>
                <form id="taskForm">
                    <div class="form-group">
                        <label for="title"><i class="fas fa-heading"></i> Title *</label>
                        <input type="text" id="title" name="title" class="form-control" required aria-required="true">
                    </div>
                    <div class="form-group">
                        <label for="description"><i class="fas fa-align-left"></i> Description</label>
                        <textarea id="description" name="description" class="form-control" rows="3"></textarea>
                    </div>
                    <div class="form-actions">
                        <button type="submit" id="submitBtn" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add Task
                        </button>
                        <button type="button" id="cancelBtn" class="btn btn-secondary" style="display: none;">
                            <i class="fas fa-times"></i> Cancel
                        </button>
                    </div>
                </form>
            </section>

            <!-- Tasks Section -->
            <section class="tasks-section">
                <h2 class="section-title"><i class="fas fa-list-check"></i> Your Tasks</h2>
                
                <div class="filter-options">
                    <div class="filter-btn active" data-filter="all">All</div>
                    <div class="filter-btn" data-filter="pending">Pending</div>
                    <div class="filter-btn" data-filter="completed">Completed</div>
                </div>

                <!-- Loading Indicator -->
                <div id="loading" class="loading">
                    <div class="spinner"></div>
                    <p>Loading your tasks...</p>
                </div>

                <!-- Error Message -->
                <div id="errorMessage" class="error-message" style="display: none;">
                    <i class="fas fa-exclamation-circle"></i>
                    <p>Failed to load tasks. Please check your connection and try again.</p>
                </div>

                <!-- Tasks List -->
                <div id="tasksList" class="tasks-grid">
                    <!-- Tasks will be dynamically inserted here -->
                </div>
            </section>
        </div>
    </div>

    <!-- Toast Notification -->
    <div id="toast" class="toast">
        <i class="fas fa-check-circle"></i>
        <p id="toastMessage">Operation completed successfully</p>
    </div>

    <script>
        // API configuration - Update this with your actual API Gateway URL
        const API_BASE = "https://t6zsqxa1l9.execute-api.eu-west-3.amazonaws.com/manara";

        // DOM elements
        const taskForm = document.getElementById('taskForm');
        const tasksList = document.getElementById('tasksList');
        const loading = document.getElementById('loading');
        const errorMessage = document.getElementById('errorMessage');
        const submitBtn = document.getElementById('submitBtn');
        const cancelBtn = document.getElementById('cancelBtn');
        const toast = document.getElementById('toast');
        const toastMessage = document.getElementById('toastMessage');
        const totalTasksEl = document.getElementById('totalTasks');
        const completedTasksEl = document.getElementById('completedTasks');
        const pendingTasksEl = document.getElementById('pendingTasks');
        const filterButtons = document.querySelectorAll('.filter-btn');

        // State variables
        let currentEditId = null;
        let tasks = [];
        let currentFilter = 'all';

        // Initialize the application
        document.addEventListener('DOMContentLoaded', function() {
            loadTasks();
            setupEventListeners();
        });

        // Set up event listeners
        function setupEventListeners() {
            taskForm.addEventListener('submit', handleFormSubmit);
            cancelBtn.addEventListener('click', resetForm);
            
            // Add filter button listeners
            filterButtons.forEach(btn => {
                btn.addEventListener('click', function() {
                    filterButtons.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    currentFilter = this.dataset.filter;
                    renderTasks();
                });
            });
        }

        // Load all tasks from the backend
        async function loadTasks() {
            showLoading();
            hideError();
            
            try {
                // Call the backend API to get tasks
                const tasksData = await getTasks();
                tasks = tasksData;
                
                updateStats();
                renderTasks();
            } catch (error) {
                console.error('Error loading tasks:', error);
                // Fallback to localStorage if API fails
                const storedTasks = localStorage.getItem('todoTasks');
                if (storedTasks) {
                    tasks = JSON.parse(storedTasks);
                    updateStats();
                    renderTasks();
                    showToast('Using offline data. Some features may not work.', 'error');
                } else {
                    showError('Failed to load tasks. Please check your connection and try again.');
                }
            } finally {
                hideLoading();
            }
        }

        // Update statistics
        function updateStats() {
            const total = tasks.length;
            const completed = tasks.filter(task => task.completed).length;
            const pending = total - completed;
            
            totalTasksEl.textContent = total;
            completedTasksEl.textContent = completed;
            pendingTasksEl.textContent = pending;
        }

        // Render tasks to the DOM based on current filter
        function renderTasks() {
            tasksList.innerHTML = '';
            
            let filteredTasks = tasks;
            if (currentFilter === 'pending') {
                filteredTasks = tasks.filter(task => !task.completed);
            } else if (currentFilter === 'completed') {
                filteredTasks = tasks.filter(task => task.completed);
            }
            
            if (filteredTasks.length === 0) {
                tasksList.innerHTML = `
                    <div class="no-tasks">
                        <i class="fas fa-clipboard-list"></i>
                        <h3>No tasks found</h3>
                        <p>Try changing your filter or add a new task</p>
                    </div>
                `;
                return;
            }
            
            // Sort tasks by update date (newest first)
            filteredTasks.sort((a, b) => new Date(b.updatedAt || b.createdAt) - new Date(a.updatedAt || a.createdAt));
            
            filteredTasks.forEach(task => {
                const taskElement = createTaskElement(task);
                tasksList.appendChild(taskElement);
            });
        }

        // Create HTML element for a single task
        function createTaskElement(task) {
            const taskCard = document.createElement('div');
            taskCard.className = `task-card ${task.completed ? 'completed' : ''}`;
            taskCard.setAttribute('data-taskid', task.taskId || task.id);
            
            const statusClass = task.completed ? 'status-completed' : 'status-pending';
            const statusText = task.completed ? 'Completed' : 'Pending';
            const statusIcon = task.completed ? 'fa-check-circle' : 'fa-clock';
            
            // Format dates correctly
            const createdDate = new Date(task.createdAt);
            const updatedDate = task.updatedAt ? new Date(task.updatedAt) : createdDate;
            
            const formattedCreatedDate = formatDate(createdDate);
            const formattedUpdatedDate = formatDate(updatedDate);
            const displayDate = formattedCreatedDate === formattedUpdatedDate 
                ? formattedCreatedDate 
                : `${formattedCreatedDate} (updated: ${formattedUpdatedDate})`;
            
            // Use taskId if available, otherwise fall back to id
            const taskIdentifier = task.taskId || task.id;
            
            taskCard.innerHTML = `
                <h3>${escapeHtml(task.title)}</h3>
                ${task.description ? `<p>${escapeHtml(task.description)}</p>` : ''}
                <div class="task-meta">
                    <span class="task-status ${statusClass}">
                        <i class="fas ${statusIcon}"></i> ${statusText}
                    </span>
                    <span class="task-date">${displayDate}</span>
                </div>
                <div class="task-actions">
                    <button class="btn btn-success" onclick="toggleTaskStatus('${taskIdentifier}')">
                        <i class="fas ${task.completed ? 'fa-undo' : 'fa-check'}"></i> ${task.completed ? 'Reopen' : 'Complete'}
                    </button>
                    <button class="btn btn-warning" onclick="editTask('${taskIdentifier}')">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <button class="btn btn-danger" onclick="deleteTask('${taskIdentifier}')">
                        <i class="fas fa-trash"></i> Delete
                    </button>
                </div>
            `;
            
            return taskCard;
        }

        // Format date for display
        function formatDate(date) {
            const now = new Date();
            const diffTime = Math.abs(now - date);
            const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));
            
            if (diffDays === 0) {
                return 'Today';
            } else if (diffDays === 1) {
                return 'Yesterday';
            } else if (diffDays < 7) {
                return `${diffDays} days ago`;
            } else {
                return date.toLocaleDateString('en-US', { 
                    year: 'numeric', 
                    month: 'short', 
                    day: 'numeric' 
                });
            }
        }

        // Handle form submission (create or update task)
        async function handleFormSubmit(event) {
            event.preventDefault();
            
            const formData = new FormData(taskForm);
            const taskData = {
                title: formData.get('title').trim(),
                description: formData.get('description').trim(),
                completed: false
            };
            
            if (!taskData.title) {
                showToast('Please enter a title for your task.', 'error');
                return;
            }
            
            try {
                let result;
                if (currentEditId) {
                    // Update existing task - call backend API
                    result = await updateTask(currentEditId, taskData);
                    
                    // Update local state with the response from backend
                    const taskIndex = tasks.findIndex(task => (task.taskId || task.id) === currentEditId);
                    if (taskIndex !== -1) {
                        tasks[taskIndex] = result;
                    }
                    showToast('Task updated successfully!', 'success');
                } else {
                    // Create new task - call backend API
                    result = await createTask(taskData);
                    
                    // Add the new task to local state
                    tasks.unshift(result);
                    showToast('Task created successfully!', 'success');
                }
                
                // Update localStorage as fallback
                localStorage.setItem('todoTasks', JSON.stringify(tasks));
                
                resetForm();
                updateStats();
                renderTasks(); // Refresh the task list
            } catch (error) {
                console.error('Error saving task:', error);
                showToast(currentEditId ? 'Failed to update task.' : 'Failed to create task.', 'error');
            }
        }

        // Edit a task - prefill the form
        function editTask(taskId) {
            const task = tasks.find(t => (t.taskId || t.id) === taskId);
            if (!task) {
                showToast('Task not found.', 'error');
                return;
            }
            
            currentEditId = taskId;
            document.getElementById('title').value = task.title;
            document.getElementById('description').value = task.description || '';
            
            submitBtn.innerHTML = '<i class="fas fa-save"></i> Update Task';
            cancelBtn.style.display = 'inline-block';
            
            // Scroll to form
            taskForm.scrollIntoView({ behavior: 'smooth' });
        }

        // Toggle task status (completed/pending)
        async function toggleTaskStatus(taskId) {
            const task = tasks.find(t => (t.taskId || t.id) === taskId);
            if (!task) {
                showToast('Task not found.', 'error');
                return;
            }
            
            try {
                const updatedTaskData = {
                    completed: !task.completed
                };
                
                // Call backend API to update task status
                const result = await updateTask(taskId, updatedTaskData);
                
                // Update local state with the response from backend
                const taskIndex = tasks.findIndex(t => (t.taskId || t.id) === taskId);
                if (taskIndex !== -1) {
                    tasks[taskIndex] = result;
                }
                
                // Update localStorage as fallback
                localStorage.setItem('todoTasks', JSON.stringify(tasks));
                
                updateStats();
                renderTasks(); // Refresh the task list
                
                showToast(`Task marked as ${result.completed ? 'completed' : 'pending'}!`, 'success');
            } catch (error) {
                console.error('Error toggling task status:', error);
                showToast('Failed to update task status.', 'error');
            }
        }

        // Delete a task with confirmation
        async function deleteTask(taskId) {
            if (!confirm('Are you sure you want to delete this task? This action cannot be undone.')) {
                return;
            }
            
            try {
                // Call backend API to delete task
                await deleteTaskFromAPI(taskId);
                
                // Remove the task from local state
                tasks = tasks.filter(task => (task.taskId || task.id) !== taskId);
                
                // Update localStorage as fallback
                localStorage.setItem('todoTasks', JSON.stringify(tasks));
                
                updateStats();
                renderTasks(); // Refresh the task list
                showToast('Task deleted successfully!', 'success');
            } catch (error) {
                console.error('Error deleting task:', error);
                showToast('Failed to delete task.', 'error');
            }
        }

        // Reset the form to its initial state
        function resetForm() {
            taskForm.reset();
            currentEditId = null;
            submitBtn.innerHTML = '<i class="fas fa-plus"></i> Add Task';
            cancelBtn.style.display = 'none';
        }

        // Show loading indicator
        function showLoading() {
            loading.style.display = 'block';
        }

        // Hide loading indicator
        function hideLoading() {
            loading.style.display = 'none';
        }

        // Show error message
        function showError(message) {
            errorMessage.querySelector('p').textContent = message;
            errorMessage.style.display = 'flex';
        }

        // Hide error message
        function hideError() {
            errorMessage.style.display = 'none';
        }

        // Show toast notification
        function showToast(message, type = 'success') {
            toastMessage.textContent = message;
            toast.className = `toast ${type}`;
            toast.innerHTML = `
                <i class="fas ${type === 'success' ? 'fa-check-circle' : 'fa-exclamation-circle'}"></i>
                <p>${message}</p>
            `;
            toast.classList.add('show');
            
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }

        // Escape HTML to prevent XSS
        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        // API functions for backend integration

        // GET /tasks - Fetch all tasks
        async function getTasks() {
            const response = await fetch(`${API_BASE}/tasks`);
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            return await response.json();
        }

        // POST /tasks - Create a new task
        async function createTask(data) {
            const response = await fetch(`${API_BASE}/tasks`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            return await response.json();
        }

        // PUT /tasks/{id} - Update a task
        async function updateTask(id, data) {
            const response = await fetch(`${API_BASE}/tasks/${id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(data),
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            return await response.json();
        }

        // DELETE /tasks/{id} - Delete a task
        async function deleteTaskFromAPI(id) {
            const response = await fetch(`${API_BASE}/tasks/${id}`, {
                method: 'DELETE',
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            return await response.json();
        }
    </script>
</body>
</html>