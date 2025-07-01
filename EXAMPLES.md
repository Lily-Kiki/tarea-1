# Examples and Usage Guide

## Overview

This document provides comprehensive examples and usage instructions for the `tarea-1` project. It includes practical code examples, common patterns, and best practices for using the APIs, functions, and components.

## Table of Contents

- [Getting Started Examples](#getting-started-examples)
- [Component Usage Examples](#component-usage-examples)
- [Function Usage Examples](#function-usage-examples)
- [API Integration Examples](#api-integration-examples)
- [Common Patterns](#common-patterns)
- [Error Handling Examples](#error-handling-examples)
- [Testing Examples](#testing-examples)
- [Performance Examples](#performance-examples)
- [Real-World Scenarios](#real-world-scenarios)

## Getting Started Examples

### Basic Project Setup

#### Installing Dependencies
```bash
# Clone the repository
git clone <repository-url>
cd tarea-1

# Install dependencies (example for different package managers)
npm install
# or
yarn install
# or
pnpm install
```

#### Basic Configuration
```typescript
// config.ts
export const config = {
  api: {
    baseUrl: process.env.API_BASE_URL || 'http://localhost:3000/api',
    timeout: 5000,
    retries: 3
  },
  ui: {
    theme: 'light',
    language: 'en'
  },
  features: {
    enableAnalytics: process.env.NODE_ENV === 'production',
    enableDebug: process.env.NODE_ENV === 'development'
  }
};
```

#### Application Entry Point
```typescript
// main.ts
import { config } from './config';
import { initializeApp } from './app';

async function bootstrap() {
  try {
    await initializeApp(config);
    console.log('Application started successfully');
  } catch (error) {
    console.error('Failed to start application:', error);
    process.exit(1);
  }
}

bootstrap();
```

## Component Usage Examples

### Basic Component Usage

#### Simple Button Component
```tsx
// React Example
import React from 'react';
import { Button } from './components/Button';

function App() {
  const handleClick = () => {
    alert('Button clicked!');
  };

  return (
    <div>
      {/* Basic button */}
      <Button onClick={handleClick}>
        Click Me
      </Button>

      {/* Button with variants */}
      <Button variant="primary" size="large">
        Primary Button
      </Button>

      <Button variant="secondary" disabled>
        Disabled Button
      </Button>

      {/* Button with loading state */}
      <Button loading>
        Loading...
      </Button>
    </div>
  );
}
```

#### Form Components
```tsx
// Form with validation example
import React, { useState } from 'react';
import { Form, Input, Button, Select } from './components';
import { validateEmail, validateRequired } from './utils/validation';

function UserForm() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    role: ''
  });
  const [errors, setErrors] = useState({});

  const handleSubmit = async (data) => {
    const validationErrors = {};
    
    if (!validateRequired(data.name)) {
      validationErrors.name = 'Name is required';
    }
    
    if (!validateEmail(data.email)) {
      validationErrors.email = 'Invalid email address';
    }
    
    if (Object.keys(validationErrors).length > 0) {
      setErrors(validationErrors);
      return;
    }

    try {
      await submitUserData(data);
      alert('User created successfully!');
    } catch (error) {
      console.error('Failed to create user:', error);
    }
  };

  return (
    <Form onSubmit={handleSubmit}>
      <Input
        label="Name"
        value={formData.name}
        onChange={(value) => setFormData({ ...formData, name: value })}
        error={errors.name}
        required
      />
      
      <Input
        label="Email"
        type="email"
        value={formData.email}
        onChange={(value) => setFormData({ ...formData, email: value })}
        error={errors.email}
        required
      />
      
      <Select
        label="Role"
        value={formData.role}
        onChange={(value) => setFormData({ ...formData, role: value })}
        options={[
          { value: 'user', label: 'User' },
          { value: 'admin', label: 'Administrator' }
        ]}
      />
      
      <Button type="submit" variant="primary">
        Create User
      </Button>
    </Form>
  );
}
```

### Advanced Component Patterns

#### Compound Components
```tsx
// Modal compound component example
import React from 'react';
import { Modal } from './components/Modal';

function App() {
  const [isOpen, setIsOpen] = useState(false);

  return (
    <div>
      <Button onClick={() => setIsOpen(true)}>
        Open Modal
      </Button>

      <Modal isOpen={isOpen} onClose={() => setIsOpen(false)}>
        <Modal.Header>
          <Modal.Title>Confirm Action</Modal.Title>
          <Modal.CloseButton />
        </Modal.Header>
        
        <Modal.Body>
          <p>Are you sure you want to perform this action?</p>
        </Modal.Body>
        
        <Modal.Footer>
          <Button variant="secondary" onClick={() => setIsOpen(false)}>
            Cancel
          </Button>
          <Button variant="danger" onClick={handleConfirm}>
            Confirm
          </Button>
        </Modal.Footer>
      </Modal>
    </div>
  );
}
```

#### Render Props Pattern
```tsx
// DataFetcher component with render props
import React from 'react';
import { DataFetcher } from './components/DataFetcher';

function UserList() {
  return (
    <DataFetcher url="/api/users">
      {({ data, loading, error, refetch }) => {
        if (loading) return <div>Loading users...</div>;
        if (error) return <div>Error: {error.message}</div>;
        
        return (
          <div>
            <Button onClick={refetch}>Refresh</Button>
            <ul>
              {data.map(user => (
                <li key={user.id}>{user.name}</li>
              ))}
            </ul>
          </div>
        );
      }}
    </DataFetcher>
  );
}
```

## Function Usage Examples

### Utility Functions

#### Debouncing Search Input
```typescript
import { debounce } from './utils/debounce';
import { searchAPI } from './api/search';

// Create debounced search function
const debouncedSearch = debounce(async (query: string) => {
  if (query.length < 3) return;
  
  try {
    const results = await searchAPI(query);
    displaySearchResults(results);
  } catch (error) {
    console.error('Search failed:', error);
  }
}, 300);

// Usage in component
function SearchInput() {
  const handleInputChange = (event) => {
    const query = event.target.value;
    debouncedSearch(query);
  };

  return (
    <input
      type="text"
      placeholder="Search..."
      onChange={handleInputChange}
    />
  );
}
```

#### Throttling Scroll Events
```typescript
import { throttle } from './utils/throttle';

// Throttled scroll handler
const handleScroll = throttle(() => {
  const scrollPercent = (window.scrollY / document.body.scrollHeight) * 100;
  updateScrollProgress(scrollPercent);
}, 100);

// Add event listener
window.addEventListener('scroll', handleScroll);

// Cleanup
window.removeEventListener('scroll', handleScroll);
```

#### Memoization for Expensive Calculations
```typescript
import { memoize } from './utils/memoize';

// Expensive calculation function
const calculateFactorial = memoize((n: number): number => {
  console.log(`Calculating factorial for ${n}`);
  if (n <= 1) return 1;
  return n * calculateFactorial(n - 1);
});

// Usage
console.log(calculateFactorial(5)); // Calculates and caches
console.log(calculateFactorial(5)); // Returns cached result
console.log(calculateFactorial(6)); // Uses cached result for factorial(5)
```

### Data Processing Examples

#### Array Grouping and Transformation
```typescript
import { groupBy, map, filter } from './utils/array';

// Sample data
const orders = [
  { id: 1, customerId: 'A', status: 'completed', amount: 100 },
  { id: 2, customerId: 'B', status: 'pending', amount: 150 },
  { id: 3, customerId: 'A', status: 'completed', amount: 200 },
  { id: 4, customerId: 'C', status: 'cancelled', amount: 75 }
];

// Group orders by customer
const ordersByCustomer = groupBy(orders, 'customerId');
console.log(ordersByCustomer);
// {
//   A: [{ id: 1, ... }, { id: 3, ... }],
//   B: [{ id: 2, ... }],
//   C: [{ id: 4, ... }]
// }

// Calculate total amount per customer
const customerTotals = Object.entries(ordersByCustomer).map(([customerId, orders]) => ({
  customerId,
  totalAmount: orders.reduce((sum, order) => sum + order.amount, 0),
  orderCount: orders.length
}));

// Filter completed orders only
const completedOrders = filter(orders, order => order.status === 'completed');

// Transform to summary format
const orderSummary = map(completedOrders, order => ({
  id: order.id,
  customer: order.customerId,
  total: `$${order.amount}`
}));
```

#### Object Manipulation
```typescript
import { pick, omit, merge } from './utils/object';

// User data from API
const userFromAPI = {
  id: 1,
  name: 'John Doe',
  email: 'john@example.com',
  password: 'hashed_password',
  createdAt: '2024-01-01',
  lastLogin: '2024-01-15',
  preferences: {
    theme: 'dark',
    notifications: true
  }
};

// Extract safe user data for frontend
const safeUser = omit(userFromAPI, ['password']);

// Extract only public information
const publicUser = pick(userFromAPI, ['id', 'name']);

// Merge with default preferences
const defaultPreferences = {
  theme: 'light',
  notifications: true,
  language: 'en'
};

const userWithDefaults = merge(userFromAPI, {
  preferences: merge(defaultPreferences, userFromAPI.preferences)
});
```

## API Integration Examples

### REST API Client
```typescript
import { createApiClient } from './utils/api';

// Create API client
const api = createApiClient('https://api.example.com', {
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${getAuthToken()}`
  },
  timeout: 10000
});

// User service
class UserService {
  async getUsers(page = 1, limit = 10) {
    return api.get<User[]>(`/users?page=${page}&limit=${limit}`);
  }

  async getUserById(id: string) {
    return api.get<User>(`/users/${id}`);
  }

  async createUser(userData: CreateUserData) {
    return api.post<User>('/users', userData);
  }

  async updateUser(id: string, userData: Partial<User>) {
    return api.put<User>(`/users/${id}`, userData);
  }

  async deleteUser(id: string) {
    return api.delete(`/users/${id}`);
  }
}

// Usage
const userService = new UserService();

async function handleUserOperations() {
  try {
    // Fetch users
    const users = await userService.getUsers(1, 20);
    console.log('Users:', users);

    // Create new user
    const newUser = await userService.createUser({
      name: 'Jane Smith',
      email: 'jane@example.com'
    });
    console.log('Created user:', newUser);

    // Update user
    const updatedUser = await userService.updateUser(newUser.id, {
      name: 'Jane Doe'
    });
    console.log('Updated user:', updatedUser);

  } catch (error) {
    console.error('API operation failed:', error);
  }
}
```

### GraphQL Integration
```typescript
import { createGraphQLClient } from './utils/graphql';

// GraphQL client setup
const graphql = createGraphQLClient('https://api.example.com/graphql', {
  headers: {
    'Authorization': `Bearer ${getAuthToken()}`
  }
});

// Query examples
const GET_USERS = `
  query GetUsers($first: Int, $after: String) {
    users(first: $first, after: $after) {
      edges {
        node {
          id
          name
          email
          createdAt
        }
      }
      pageInfo {
        hasNextPage
        endCursor
      }
    }
  }
`;

const CREATE_USER = `
  mutation CreateUser($input: CreateUserInput!) {
    createUser(input: $input) {
      user {
        id
        name
        email
      }
      errors {
        field
        message
      }
    }
  }
`;

// Usage
async function fetchUsers() {
  const { data } = await graphql.query(GET_USERS, {
    first: 10
  });
  
  return data.users.edges.map(edge => edge.node);
}

async function createUser(userData) {
  const { data } = await graphql.mutate(CREATE_USER, {
    input: userData
  });
  
  if (data.createUser.errors.length > 0) {
    throw new Error('Validation failed: ' + data.createUser.errors[0].message);
  }
  
  return data.createUser.user;
}
```

## Common Patterns

### State Management
```typescript
// Custom state management hook
import { useState, useEffect, useCallback } from 'react';

function useAsyncState<T>(asyncFn: () => Promise<T>, deps: any[] = []) {
  const [state, setState] = useState<{
    data: T | null;
    loading: boolean;
    error: Error | null;
  }>({
    data: null,
    loading: true,
    error: null
  });

  const execute = useCallback(async () => {
    setState(prev => ({ ...prev, loading: true, error: null }));
    
    try {
      const data = await asyncFn();
      setState({ data, loading: false, error: null });
    } catch (error) {
      setState({ data: null, loading: false, error: error as Error });
    }
  }, deps);

  useEffect(() => {
    execute();
  }, [execute]);

  return { ...state, refetch: execute };
}

// Usage
function UserProfile({ userId }: { userId: string }) {
  const { data: user, loading, error, refetch } = useAsyncState(
    () => userService.getUserById(userId),
    [userId]
  );

  if (loading) return <div>Loading...</div>;
  if (error) return <div>Error: {error.message}</div>;
  if (!user) return <div>User not found</div>;

  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
      <Button onClick={refetch}>Refresh</Button>
    </div>
  );
}
```

### Event System
```typescript
import { createEventEmitter } from './utils/events';

// Application-wide event system
interface AppEvents {
  'user:login': { user: User; timestamp: Date };
  'user:logout': { userId: string };
  'notification:show': { message: string; type: 'success' | 'error' | 'info' };
  'modal:open': { modalId: string; props?: any };
  'modal:close': { modalId: string };
}

export const appEvents = createEventEmitter<AppEvents>();

// Event handlers
appEvents.on('user:login', ({ user, timestamp }) => {
  console.log(`User ${user.name} logged in at ${timestamp}`);
  // Track analytics
  analytics.track('user_login', { userId: user.id });
});

appEvents.on('notification:show', ({ message, type }) => {
  // Show notification in UI
  notificationService.show(message, type);
});

// Usage in components
function LoginForm() {
  const handleLogin = async (credentials) => {
    try {
      const user = await authService.login(credentials);
      
      // Emit login event
      appEvents.emit('user:login', {
        user,
        timestamp: new Date()
      });
      
      // Show success notification
      appEvents.emit('notification:show', {
        message: 'Login successful!',
        type: 'success'
      });
      
    } catch (error) {
      appEvents.emit('notification:show', {
        message: 'Login failed: ' + error.message,
        type: 'error'
      });
    }
  };

  return (
    <Form onSubmit={handleLogin}>
      {/* Form fields */}
    </Form>
  );
}
```

### Data Validation
```typescript
import { createValidator, isEmail, isRequired, minLength } from './utils/validation';

// Define validation schema
const userValidationSchema = {
  name: [isRequired('Name is required'), minLength(2, 'Name must be at least 2 characters')],
  email: [isRequired('Email is required'), isEmail('Invalid email format')],
  password: [
    isRequired('Password is required'),
    minLength(8, 'Password must be at least 8 characters'),
    (value: string) => {
      if (!/(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/.test(value)) {
        return 'Password must contain at least one lowercase letter, one uppercase letter, and one number';
      }
      return null;
    }
  ]
};

const validateUser = createValidator(userValidationSchema);

// Usage
function UserRegistrationForm() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    password: ''
  });
  
  const [errors, setErrors] = useState({});

  const handleSubmit = async (event) => {
    event.preventDefault();
    
    const validationResult = validateUser(formData);
    
    if (!validationResult.isValid) {
      setErrors(validationResult.errors);
      return;
    }

    try {
      await userService.createUser(formData);
      // Handle success
    } catch (error) {
      // Handle error
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <Input
        label="Name"
        value={formData.name}
        onChange={(value) => setFormData({ ...formData, name: value })}
        error={errors.name}
      />
      <Input
        label="Email"
        type="email"
        value={formData.email}
        onChange={(value) => setFormData({ ...formData, email: value })}
        error={errors.email}
      />
      <Input
        label="Password"
        type="password"
        value={formData.password}
        onChange={(value) => setFormData({ ...formData, password: value })}
        error={errors.password}
      />
      <Button type="submit">Register</Button>
    </form>
  );
}
```

## Error Handling Examples

### Centralized Error Handling
```typescript
// Error handling service
class ErrorHandler {
  private static instance: ErrorHandler;
  
  static getInstance() {
    if (!ErrorHandler.instance) {
      ErrorHandler.instance = new ErrorHandler();
    }
    return ErrorHandler.instance;
  }

  handleError(error: Error, context?: string) {
    // Log error
    console.error(`[${context || 'Unknown'}] Error:`, error);
    
    // Send to monitoring service
    if (process.env.NODE_ENV === 'production') {
      this.sendToMonitoring(error, context);
    }
    
    // Show user-friendly message
    this.showUserNotification(error);
  }

  private sendToMonitoring(error: Error, context?: string) {
    // Integration with error monitoring service
    monitoring.captureException(error, { context });
  }

  private showUserNotification(error: Error) {
    let message = 'An unexpected error occurred';
    
    if (error instanceof ValidationError) {
      message = error.message;
    } else if (error instanceof ApiError) {
      message = 'Server error. Please try again later.';
    }
    
    appEvents.emit('notification:show', {
      message,
      type: 'error'
    });
  }
}

// Global error handler
const errorHandler = ErrorHandler.getInstance();

// Usage with API calls
async function safeApiCall<T>(apiCall: () => Promise<T>, context?: string): Promise<T | null> {
  try {
    return await apiCall();
  } catch (error) {
    errorHandler.handleError(error as Error, context);
    return null;
  }
}

// Usage
async function loadUserData(userId: string) {
  const user = await safeApiCall(
    () => userService.getUserById(userId),
    'loadUserData'
  );
  
  if (user) {
    // Handle successful data load
    setUser(user);
  }
  // Error is already handled by safeApiCall
}
```

### React Error Boundaries
```tsx
import React, { Component, ErrorInfo, ReactNode } from 'react';

interface Props {
  children: ReactNode;
  fallback?: ReactNode;
  onError?: (error: Error, errorInfo: ErrorInfo) => void;
}

interface State {
  hasError: boolean;
  error?: Error;
}

class ErrorBoundary extends Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('Error boundary caught an error:', error, errorInfo);
    
    // Call custom error handler
    this.props.onError?.(error, errorInfo);
    
    // Send to error monitoring
    errorHandler.handleError(error, 'React Error Boundary');
  }

  render() {
    if (this.state.hasError) {
      return this.props.fallback || (
        <div className="error-fallback">
          <h2>Something went wrong</h2>
          <p>We're sorry, but something unexpected happened.</p>
          <Button onClick={() => window.location.reload()}>
            Reload Page
          </Button>
        </div>
      );
    }

    return this.props.children;
  }
}

// Usage
function App() {
  return (
    <ErrorBoundary
      fallback={<ErrorFallback />}
      onError={(error, errorInfo) => {
        // Custom error handling logic
        analytics.track('react_error', {
          error: error.message,
          stack: error.stack,
          componentStack: errorInfo.componentStack
        });
      }}
    >
      <Router>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/users" element={<UsersPage />} />
          {/* Other routes */}
        </Routes>
      </Router>
    </ErrorBoundary>
  );
}
```

## Testing Examples

### Unit Testing
```typescript
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { UserForm } from './UserForm';
import { userService } from '../services/userService';

// Mock external dependencies
jest.mock('../services/userService');
const mockUserService = userService as jest.Mocked<typeof userService>;

describe('UserForm', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  it('renders form fields correctly', () => {
    render(<UserForm />);
    
    expect(screen.getByLabelText(/name/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/email/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /submit/i })).toBeInTheDocument();
  });

  it('validates required fields', async () => {
    const user = userEvent.setup();
    render(<UserForm />);
    
    const submitButton = screen.getByRole('button', { name: /submit/i });
    await user.click(submitButton);
    
    expect(screen.getByText(/name is required/i)).toBeInTheDocument();
    expect(screen.getByText(/email is required/i)).toBeInTheDocument();
  });

  it('submits form with valid data', async () => {
    const user = userEvent.setup();
    mockUserService.createUser.mockResolvedValue({ id: '1', name: 'John', email: 'john@example.com' });
    
    render(<UserForm />);
    
    await user.type(screen.getByLabelText(/name/i), 'John Doe');
    await user.type(screen.getByLabelText(/email/i), 'john@example.com');
    await user.click(screen.getByRole('button', { name: /submit/i }));
    
    await waitFor(() => {
      expect(mockUserService.createUser).toHaveBeenCalledWith({
        name: 'John Doe',
        email: 'john@example.com'
      });
    });
  });

  it('handles submission errors', async () => {
    const user = userEvent.setup();
    mockUserService.createUser.mockRejectedValue(new Error('Server error'));
    
    render(<UserForm />);
    
    await user.type(screen.getByLabelText(/name/i), 'John Doe');
    await user.type(screen.getByLabelText(/email/i), 'john@example.com');
    await user.click(screen.getByRole('button', { name: /submit/i }));
    
    await waitFor(() => {
      expect(screen.getByText(/server error/i)).toBeInTheDocument();
    });
  });
});
```

### Integration Testing
```typescript
import { setupTestDatabase, teardownTestDatabase } from '../test-utils/database';
import { createTestUser, createTestServer } from '../test-utils/factories';
import request from 'supertest';

describe('User API Integration', () => {
  let app: any;
  let database: any;

  beforeAll(async () => {
    database = await setupTestDatabase();
    app = createTestServer(database);
  });

  afterAll(async () => {
    await teardownTestDatabase(database);
  });

  beforeEach(async () => {
    await database.clear();
  });

  describe('POST /api/users', () => {
    it('creates a new user successfully', async () => {
      const userData = {
        name: 'John Doe',
        email: 'john@example.com'
      };

      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(201);

      expect(response.body).toMatchObject({
        id: expect.any(String),
        name: userData.name,
        email: userData.email,
        createdAt: expect.any(String)
      });
    });

    it('returns validation error for invalid email', async () => {
      const userData = {
        name: 'John Doe',
        email: 'invalid-email'
      };

      const response = await request(app)
        .post('/api/users')
        .send(userData)
        .expect(400);

      expect(response.body.errors).toContain('Invalid email format');
    });
  });

  describe('GET /api/users/:id', () => {
    it('returns user by id', async () => {
      const user = await createTestUser(database, {
        name: 'Jane Doe',
        email: 'jane@example.com'
      });

      const response = await request(app)
        .get(`/api/users/${user.id}`)
        .expect(200);

      expect(response.body).toMatchObject({
        id: user.id,
        name: user.name,
        email: user.email
      });
    });

    it('returns 404 for non-existent user', async () => {
      await request(app)
        .get('/api/users/non-existent-id')
        .expect(404);
    });
  });
});
```

## Performance Examples

### Code Splitting and Lazy Loading
```typescript
// React lazy loading
import React, { Suspense, lazy } from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { LoadingSpinner } from './components/LoadingSpinner';

// Lazy load components
const HomePage = lazy(() => import('./pages/HomePage'));
const UsersPage = lazy(() => import('./pages/UsersPage'));
const UserDetailPage = lazy(() => import('./pages/UserDetailPage'));
const AdminPage = lazy(() => import('./pages/AdminPage'));

function App() {
  return (
    <Router>
      <Suspense fallback={<LoadingSpinner />}>
        <Routes>
          <Route path="/" element={<HomePage />} />
          <Route path="/users" element={<UsersPage />} />
          <Route path="/users/:id" element={<UserDetailPage />} />
          <Route 
            path="/admin" 
            element={
              <ProtectedRoute>
                <AdminPage />
              </ProtectedRoute>
            } 
          />
        </Routes>
      </Suspense>
    </Router>
  );
}
```

### Memoization and Optimization
```typescript
import React, { memo, useMemo, useCallback } from 'react';

// Memoized component
const UserCard = memo<{ user: User; onEdit: (user: User) => void }>(
  ({ user, onEdit }) => {
    const handleEdit = useCallback(() => {
      onEdit(user);
    }, [user, onEdit]);

    const formattedDate = useMemo(() => {
      return formatDate(user.createdAt, 'MMM DD, YYYY');
    }, [user.createdAt]);

    return (
      <div className="user-card">
        <h3>{user.name}</h3>
        <p>{user.email}</p>
        <p>Joined: {formattedDate}</p>
        <Button onClick={handleEdit}>Edit</Button>
      </div>
    );
  }
);

// Optimized user list
function UserList({ users }: { users: User[] }) {
  const [editingUser, setEditingUser] = useState<User | null>(null);

  // Memoize expensive calculations
  const sortedUsers = useMemo(() => {
    return [...users].sort((a, b) => a.name.localeCompare(b.name));
  }, [users]);

  // Memoize callback to prevent unnecessary re-renders
  const handleEditUser = useCallback((user: User) => {
    setEditingUser(user);
  }, []);

  return (
    <div className="user-list">
      {sortedUsers.map(user => (
        <UserCard key={user.id} user={user} onEdit={handleEditUser} />
      ))}
      
      {editingUser && (
        <EditUserModal
          user={editingUser}
          onClose={() => setEditingUser(null)}
        />
      )}
    </div>
  );
}
```

### Virtual Scrolling for Large Lists
```typescript
import React, { useMemo } from 'react';
import { FixedSizeList as List } from 'react-window';

interface VirtualizedListProps {
  items: any[];
  itemHeight: number;
  height: number;
  renderItem: (props: { index: number; style: any }) => React.ReactNode;
}

function VirtualizedList({ items, itemHeight, height, renderItem }: VirtualizedListProps) {
  const itemCount = items.length;

  const Row = ({ index, style }: { index: number; style: any }) => (
    <div style={style}>
      {renderItem({ index, style })}
    </div>
  );

  return (
    <List
      height={height}
      itemCount={itemCount}
      itemSize={itemHeight}
      itemData={items}
    >
      {Row}
    </List>
  );
}

// Usage with large dataset
function LargeUserList({ users }: { users: User[] }) {
  const renderUserItem = ({ index }: { index: number }) => {
    const user = users[index];
    return (
      <div className="user-item">
        <span>{user.name}</span>
        <span>{user.email}</span>
      </div>
    );
  };

  return (
    <VirtualizedList
      items={users}
      itemHeight={50}
      height={400}
      renderItem={renderUserItem}
    />
  );
}
```

## Real-World Scenarios

### Complete CRUD Application
```typescript
// User management application
import React, { useState, useEffect } from 'react';
import { UserService } from './services/UserService';
import { UserList } from './components/UserList';
import { UserForm } from './components/UserForm';
import { Modal } from './components/Modal';
import { Button } from './components/Button';
import { SearchInput } from './components/SearchInput';
import { Pagination } from './components/Pagination';

function UserManagementApp() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [searchQuery, setSearchQuery] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(0);
  const [showCreateModal, setShowCreateModal] = useState(false);
  const [editingUser, setEditingUser] = useState<User | null>(null);

  const userService = new UserService();

  // Load users with pagination and search
  const loadUsers = useCallback(async (page = 1, search = '') => {
    setLoading(true);
    setError(null);

    try {
      const response = await userService.getUsers({
        page,
        limit: 20,
        search
      });
      
      setUsers(response.data);
      setTotalPages(response.totalPages);
      setCurrentPage(page);
    } catch (err) {
      setError('Failed to load users');
      console.error(err);
    } finally {
      setLoading(false);
    }
  }, []);

  // Load users on mount and when search/page changes
  useEffect(() => {
    loadUsers(currentPage, searchQuery);
  }, [loadUsers, currentPage, searchQuery]);

  // Handle user creation
  const handleCreateUser = async (userData: CreateUserData) => {
    try {
      await userService.createUser(userData);
      setShowCreateModal(false);
      loadUsers(currentPage, searchQuery); // Refresh list
      
      // Show success notification
      appEvents.emit('notification:show', {
        message: 'User created successfully!',
        type: 'success'
      });
    } catch (err) {
      console.error('Failed to create user:', err);
    }
  };

  // Handle user update
  const handleUpdateUser = async (userId: string, userData: Partial<User>) => {
    try {
      await userService.updateUser(userId, userData);
      setEditingUser(null);
      loadUsers(currentPage, searchQuery); // Refresh list
      
      appEvents.emit('notification:show', {
        message: 'User updated successfully!',
        type: 'success'
      });
    } catch (err) {
      console.error('Failed to update user:', err);
    }
  };

  // Handle user deletion
  const handleDeleteUser = async (userId: string) => {
    if (!confirm('Are you sure you want to delete this user?')) {
      return;
    }

    try {
      await userService.deleteUser(userId);
      loadUsers(currentPage, searchQuery); // Refresh list
      
      appEvents.emit('notification:show', {
        message: 'User deleted successfully!',
        type: 'success'
      });
    } catch (err) {
      console.error('Failed to delete user:', err);
    }
  };

  // Debounced search
  const debouncedSearch = useCallback(
    debounce((query: string) => {
      setSearchQuery(query);
      setCurrentPage(1); // Reset to first page on search
    }, 300),
    []
  );

  if (loading && users.length === 0) {
    return <div className="loading">Loading users...</div>;
  }

  return (
    <div className="user-management">
      <header className="page-header">
        <h1>User Management</h1>
        <Button onClick={() => setShowCreateModal(true)}>
          Add New User
        </Button>
      </header>

      <div className="controls">
        <SearchInput
          placeholder="Search users..."
          onSearch={debouncedSearch}
        />
      </div>

      {error && (
        <div className="error-message">
          {error}
          <Button onClick={() => loadUsers(currentPage, searchQuery)}>
            Retry
          </Button>
        </div>
      )}

      <UserList
        users={users}
        onEdit={setEditingUser}
        onDelete={handleDeleteUser}
        loading={loading}
      />

      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setCurrentPage}
      />

      {/* Create User Modal */}
      <Modal
        isOpen={showCreateModal}
        onClose={() => setShowCreateModal(false)}
        title="Create New User"
      >
        <UserForm
          onSubmit={handleCreateUser}
          onCancel={() => setShowCreateModal(false)}
        />
      </Modal>

      {/* Edit User Modal */}
      <Modal
        isOpen={!!editingUser}
        onClose={() => setEditingUser(null)}
        title="Edit User"
      >
        {editingUser && (
          <UserForm
            initialData={editingUser}
            onSubmit={(data) => handleUpdateUser(editingUser.id, data)}
            onCancel={() => setEditingUser(null)}
          />
        )}
      </Modal>
    </div>
  );
}

export default UserManagementApp;
```

---

**Note**: These examples serve as comprehensive templates and will be updated as the actual implementation progresses. Each example follows best practices and demonstrates real-world usage patterns for the documented APIs, functions, and components.