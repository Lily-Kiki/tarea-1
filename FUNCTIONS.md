# Function Documentation

## Overview

This document provides comprehensive documentation for all public functions and utilities in the `tarea-1` project. Functions are organized by category and include detailed usage examples, parameter descriptions, and error handling information.

## Table of Contents

- [Function Categories](#function-categories)
- [Documentation Standards](#documentation-standards)
- [Utility Functions](#utility-functions)
- [Data Processing Functions](#data-processing-functions)
- [Validation Functions](#validation-functions)
- [HTTP/API Functions](#httpapi-functions)
- [Event Handling Functions](#event-handling-functions)
- [Math and Calculation Functions](#math-and-calculation-functions)
- [Date and Time Functions](#date-and-time-functions)
- [String Manipulation Functions](#string-manipulation-functions)
- [Array and Object Functions](#array-and-object-functions)
- [Async/Promise Functions](#asyncpromise-functions)
- [Error Handling](#error-handling)
- [Testing Functions](#testing-functions)

## Function Categories

### Classification System
Functions are classified into the following categories:

- **Utility**: General-purpose helper functions
- **Data Processing**: Functions that transform, filter, or manipulate data
- **Validation**: Functions that validate input or data integrity
- **HTTP/API**: Functions for making network requests and handling responses
- **Event Handling**: Functions for managing DOM and custom events
- **Math**: Mathematical calculations and algorithms
- **Date/Time**: Date and time manipulation functions
- **String**: String processing and formatting functions
- **Array/Object**: Data structure manipulation functions
- **Async**: Asynchronous operations and Promise handling

## Documentation Standards

### Function Documentation Template

```typescript
/**
 * Brief description of what the function does
 * 
 * @category CategoryName
 * @param {Type} paramName - Description of parameter
 * @param {Type} [optionalParam] - Description of optional parameter
 * @returns {ReturnType} Description of return value
 * @throws {ErrorType} Description of when error is thrown
 * @example
 * ```typescript
 * const result = functionName(param1, param2);
 * console.log(result); // Expected output
 * ```
 * @since 1.0.0
 */
function functionName(paramName: Type, optionalParam?: Type): ReturnType {
  // Implementation
}
```

### JSDoc Standards
- Use `@category` to classify functions
- Use `@param` for all parameters with type and description
- Use `@returns` to describe return value
- Use `@throws` to document possible errors
- Use `@example` to provide usage examples
- Use `@since` to indicate version when function was added
- Use `@deprecated` for deprecated functions with migration path

## Utility Functions

### Example Utility Functions

#### debounce

**Description**: Creates a debounced function that delays invoking the provided function until after wait milliseconds have elapsed since the last time the debounced function was invoked.

**Category**: Utility

**Signature**:
```typescript
function debounce<T extends (...args: any[]) => any>(
  func: T,
  wait: number,
  immediate?: boolean
): (...args: Parameters<T>) => void
```

**Parameters**:
- `func` (Function): The function to debounce
- `wait` (number): The number of milliseconds to delay
- `immediate` (boolean, optional): Whether to trigger the function on the leading edge

**Returns**: Debounced function

**Example**:
```typescript
const debouncedSearch = debounce((query: string) => {
  console.log('Searching for:', query);
}, 300);

// Usage
debouncedSearch('hello'); // Will only execute after 300ms of no more calls
debouncedSearch('hello world'); // Cancels previous call
```

**Implementation**:
```typescript
function debounce<T extends (...args: any[]) => any>(
  func: T,
  wait: number,
  immediate: boolean = false
): (...args: Parameters<T>) => void {
  let timeout: NodeJS.Timeout | null = null;
  
  return function executedFunction(...args: Parameters<T>) {
    const later = () => {
      timeout = null;
      if (!immediate) func(...args);
    };
    
    const callNow = immediate && !timeout;
    
    if (timeout) clearTimeout(timeout);
    timeout = setTimeout(later, wait);
    
    if (callNow) func(...args);
  };
}
```

#### throttle

**Description**: Creates a throttled function that only invokes the provided function at most once per every wait milliseconds.

**Category**: Utility

**Signature**:
```typescript
function throttle<T extends (...args: any[]) => any>(
  func: T,
  wait: number
): (...args: Parameters<T>) => void
```

**Parameters**:
- `func` (Function): The function to throttle
- `wait` (number): The number of milliseconds to throttle invocations to

**Returns**: Throttled function

**Example**:
```typescript
const throttledScroll = throttle(() => {
  console.log('Scroll event processed');
}, 100);

window.addEventListener('scroll', throttledScroll);
```

#### memoize

**Description**: Creates a memoized version of a function that caches results based on arguments.

**Category**: Utility

**Signature**:
```typescript
function memoize<T extends (...args: any[]) => any>(
  func: T,
  getKey?: (...args: Parameters<T>) => string
): T & { cache: Map<string, ReturnType<T>>; clear: () => void }
```

**Example**:
```typescript
const fibonacci = memoize((n: number): number => {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
});

console.log(fibonacci(10)); // Calculated once
console.log(fibonacci(10)); // Retrieved from cache
```

## Data Processing Functions

### Array Processing

#### groupBy

**Description**: Groups array elements by a specified key or function result.

**Category**: Data Processing

**Signature**:
```typescript
function groupBy<T, K extends string | number>(
  array: T[],
  keyOrFn: keyof T | ((item: T) => K)
): Record<K, T[]>
```

**Parameters**:
- `array` (Array): The array to group
- `keyOrFn` (string | Function): Property key or function to group by

**Returns**: Object with grouped arrays

**Example**:
```typescript
const users = [
  { name: 'John', role: 'admin' },
  { name: 'Jane', role: 'user' },
  { name: 'Bob', role: 'admin' }
];

const grouped = groupBy(users, 'role');
// Result: { admin: [John, Bob], user: [Jane] }

const groupedByLength = groupBy(users, user => user.name.length);
// Result: { 3: [Bob], 4: [John, Jane] }
```

#### chunk

**Description**: Splits array into chunks of specified size.

**Category**: Data Processing

**Signature**:
```typescript
function chunk<T>(array: T[], size: number): T[][]
```

**Example**:
```typescript
const numbers = [1, 2, 3, 4, 5, 6, 7];
const chunks = chunk(numbers, 3);
// Result: [[1, 2, 3], [4, 5, 6], [7]]
```

### Object Processing

#### pick

**Description**: Creates an object with only the specified properties.

**Category**: Data Processing

**Signature**:
```typescript
function pick<T, K extends keyof T>(obj: T, keys: K[]): Pick<T, K>
```

**Example**:
```typescript
const user = { id: 1, name: 'John', email: 'john@example.com', password: 'secret' };
const publicUser = pick(user, ['id', 'name', 'email']);
// Result: { id: 1, name: 'John', email: 'john@example.com' }
```

#### omit

**Description**: Creates an object without the specified properties.

**Category**: Data Processing

**Signature**:
```typescript
function omit<T, K extends keyof T>(obj: T, keys: K[]): Omit<T, K>
```

**Example**:
```typescript
const user = { id: 1, name: 'John', email: 'john@example.com', password: 'secret' };
const safeUser = omit(user, ['password']);
// Result: { id: 1, name: 'John', email: 'john@example.com' }
```

## Validation Functions

#### isEmail

**Description**: Validates if a string is a valid email address.

**Category**: Validation

**Signature**:
```typescript
function isEmail(email: string): boolean
```

**Example**:
```typescript
console.log(isEmail('user@example.com')); // true
console.log(isEmail('invalid-email'));    // false
```

#### isUrl

**Description**: Validates if a string is a valid URL.

**Category**: Validation

**Signature**:
```typescript
function isUrl(url: string): boolean
```

**Example**:
```typescript
console.log(isUrl('https://example.com')); // true
console.log(isUrl('not-a-url'));          // false
```

#### validateSchema

**Description**: Validates an object against a schema definition.

**Category**: Validation

**Signature**:
```typescript
interface ValidationResult {
  isValid: boolean;
  errors: string[];
}

function validateSchema<T>(
  data: unknown,
  schema: Schema<T>
): ValidationResult & { data?: T }
```

**Example**:
```typescript
const userSchema = {
  name: { type: 'string', required: true },
  age: { type: 'number', min: 0, max: 120 },
  email: { type: 'string', validator: isEmail }
};

const result = validateSchema(userData, userSchema);
if (result.isValid) {
  console.log('Valid user:', result.data);
} else {
  console.log('Validation errors:', result.errors);
}
```

## HTTP/API Functions

#### apiRequest

**Description**: Makes HTTP requests with built-in error handling and response transformation.

**Category**: HTTP/API

**Signature**:
```typescript
interface ApiRequestOptions {
  method?: 'GET' | 'POST' | 'PUT' | 'DELETE' | 'PATCH';
  headers?: Record<string, string>;
  body?: any;
  timeout?: number;
  retries?: number;
}

function apiRequest<T = any>(
  url: string,
  options?: ApiRequestOptions
): Promise<T>
```

**Example**:
```typescript
// GET request
const users = await apiRequest<User[]>('/api/users');

// POST request
const newUser = await apiRequest<User>('/api/users', {
  method: 'POST',
  body: { name: 'John', email: 'john@example.com' }
});

// With error handling
try {
  const data = await apiRequest('/api/data');
} catch (error) {
  console.error('API request failed:', error.message);
}
```

#### createApiClient

**Description**: Creates a configured API client with base URL and default options.

**Category**: HTTP/API

**Signature**:
```typescript
interface ApiClient {
  get<T>(path: string, options?: Partial<ApiRequestOptions>): Promise<T>;
  post<T>(path: string, data?: any, options?: Partial<ApiRequestOptions>): Promise<T>;
  put<T>(path: string, data?: any, options?: Partial<ApiRequestOptions>): Promise<T>;
  delete<T>(path: string, options?: Partial<ApiRequestOptions>): Promise<T>;
}

function createApiClient(baseUrl: string, defaultOptions?: ApiRequestOptions): ApiClient
```

**Example**:
```typescript
const api = createApiClient('https://api.example.com', {
  headers: { 'Authorization': 'Bearer token' }
});

const users = await api.get<User[]>('/users');
const newUser = await api.post<User>('/users', userData);
```

## Event Handling Functions

#### createEventEmitter

**Description**: Creates a type-safe event emitter for custom events.

**Category**: Event Handling

**Signature**:
```typescript
interface EventEmitter<Events = Record<string, any>> {
  on<K extends keyof Events>(event: K, listener: (data: Events[K]) => void): void;
  off<K extends keyof Events>(event: K, listener: (data: Events[K]) => void): void;
  emit<K extends keyof Events>(event: K, data: Events[K]): void;
  once<K extends keyof Events>(event: K, listener: (data: Events[K]) => void): void;
}

function createEventEmitter<Events = Record<string, any>>(): EventEmitter<Events>
```

**Example**:
```typescript
interface UserEvents {
  login: { userId: string; timestamp: Date };
  logout: { userId: string };
  error: { message: string; code: number };
}

const userEmitter = createEventEmitter<UserEvents>();

userEmitter.on('login', (data) => {
  console.log(`User ${data.userId} logged in at ${data.timestamp}`);
});

userEmitter.emit('login', { userId: '123', timestamp: new Date() });
```

#### addEventListener

**Description**: Enhanced event listener with automatic cleanup and type safety.

**Category**: Event Handling

**Signature**:
```typescript
function addEventListener<K extends keyof HTMLElementEventMap>(
  element: HTMLElement,
  type: K,
  listener: (event: HTMLElementEventMap[K]) => void,
  options?: AddEventListenerOptions
): () => void
```

**Example**:
```typescript
const button = document.querySelector('button');
const removeListener = addEventListener(button, 'click', (event) => {
  console.log('Button clicked!', event);
});

// Cleanup
removeListener();
```

## Math and Calculation Functions

#### clamp

**Description**: Clamps a number between a minimum and maximum value.

**Category**: Math

**Signature**:
```typescript
function clamp(value: number, min: number, max: number): number
```

**Example**:
```typescript
console.log(clamp(5, 0, 10));   // 5
console.log(clamp(-5, 0, 10));  // 0
console.log(clamp(15, 0, 10));  // 10
```

#### lerp

**Description**: Linear interpolation between two values.

**Category**: Math

**Signature**:
```typescript
function lerp(start: number, end: number, t: number): number
```

**Example**:
```typescript
console.log(lerp(0, 100, 0.5));  // 50
console.log(lerp(10, 20, 0.25)); // 12.5
```

#### randomBetween

**Description**: Generates a random number between min and max (inclusive).

**Category**: Math

**Signature**:
```typescript
function randomBetween(min: number, max: number): number
```

**Example**:
```typescript
const random = randomBetween(1, 10);
console.log(random); // Random number between 1 and 10
```

## Date and Time Functions

#### formatDate

**Description**: Formats a date according to the specified format string.

**Category**: Date/Time

**Signature**:
```typescript
function formatDate(date: Date, format: string): string
```

**Parameters**:
- `date` (Date): The date to format
- `format` (string): Format string (e.g., 'YYYY-MM-DD', 'MM/DD/YYYY HH:mm')

**Example**:
```typescript
const date = new Date('2024-01-15T14:30:00');
console.log(formatDate(date, 'YYYY-MM-DD'));        // '2024-01-15'
console.log(formatDate(date, 'MM/DD/YYYY HH:mm'));  // '01/15/2024 14:30'
```

#### addDays

**Description**: Adds the specified number of days to a date.

**Category**: Date/Time

**Signature**:
```typescript
function addDays(date: Date, days: number): Date
```

**Example**:
```typescript
const today = new Date();
const futureDate = addDays(today, 7); // 7 days from now
```

#### isWeekend

**Description**: Checks if a date falls on a weekend.

**Category**: Date/Time

**Signature**:
```typescript
function isWeekend(date: Date): boolean
```

**Example**:
```typescript
const saturday = new Date('2024-01-13');
console.log(isWeekend(saturday)); // true
```

## String Manipulation Functions

#### toCamelCase

**Description**: Converts a string to camelCase.

**Category**: String

**Signature**:
```typescript
function toCamelCase(str: string): string
```

**Example**:
```typescript
console.log(toCamelCase('hello-world'));     // 'helloWorld'
console.log(toCamelCase('hello_world'));     // 'helloWorld'
console.log(toCamelCase('Hello World'));     // 'helloWorld'
```

#### toKebabCase

**Description**: Converts a string to kebab-case.

**Category**: String

**Signature**:
```typescript
function toKebabCase(str: string): string
```

**Example**:
```typescript
console.log(toKebabCase('helloWorld'));   // 'hello-world'
console.log(toKebabCase('Hello World'));  // 'hello-world'
```

#### truncate

**Description**: Truncates a string to the specified length with optional ellipsis.

**Category**: String

**Signature**:
```typescript
function truncate(str: string, length: number, ellipsis?: string): string
```

**Example**:
```typescript
const longText = 'This is a very long text that needs to be truncated';
console.log(truncate(longText, 20));        // 'This is a very long...'
console.log(truncate(longText, 20, '…'));   // 'This is a very long…'
```

## Array and Object Functions

#### deepClone

**Description**: Creates a deep clone of an object or array.

**Category**: Array/Object

**Signature**:
```typescript
function deepClone<T>(obj: T): T
```

**Example**:
```typescript
const original = { a: 1, b: { c: 2 } };
const cloned = deepClone(original);
cloned.b.c = 3;
console.log(original.b.c); // Still 2
```

#### deepEqual

**Description**: Performs deep equality comparison between two values.

**Category**: Array/Object

**Signature**:
```typescript
function deepEqual(a: any, b: any): boolean
```

**Example**:
```typescript
const obj1 = { a: 1, b: { c: 2 } };
const obj2 = { a: 1, b: { c: 2 } };
console.log(deepEqual(obj1, obj2)); // true
```

#### merge

**Description**: Recursively merges objects together.

**Category**: Array/Object

**Signature**:
```typescript
function merge<T extends Record<string, any>>(...objects: Partial<T>[]): T
```

**Example**:
```typescript
const obj1 = { a: 1, b: { c: 2 } };
const obj2 = { b: { d: 3 }, e: 4 };
const merged = merge(obj1, obj2);
// Result: { a: 1, b: { c: 2, d: 3 }, e: 4 }
```

## Async/Promise Functions

#### sleep

**Description**: Creates a promise that resolves after the specified delay.

**Category**: Async

**Signature**:
```typescript
function sleep(ms: number): Promise<void>
```

**Example**:
```typescript
async function example() {
  console.log('Start');
  await sleep(1000); // Wait 1 second
  console.log('End');
}
```

#### retry

**Description**: Retries an async function with exponential backoff.

**Category**: Async

**Signature**:
```typescript
interface RetryOptions {
  retries: number;
  delay?: number;
  backoff?: number;
}

function retry<T>(
  fn: () => Promise<T>,
  options: RetryOptions
): Promise<T>
```

**Example**:
```typescript
const data = await retry(
  () => apiRequest('/unreliable-endpoint'),
  { retries: 3, delay: 1000, backoff: 2 }
);
```

#### timeout

**Description**: Adds a timeout to a promise.

**Category**: Async

**Signature**:
```typescript
function timeout<T>(promise: Promise<T>, ms: number): Promise<T>
```

**Example**:
```typescript
try {
  const result = await timeout(apiRequest('/slow-endpoint'), 5000);
} catch (error) {
  if (error.name === 'TimeoutError') {
    console.log('Request timed out');
  }
}
```

## Error Handling

### Custom Error Classes

```typescript
class ValidationError extends Error {
  constructor(message: string, public field: string) {
    super(message);
    this.name = 'ValidationError';
  }
}

class ApiError extends Error {
  constructor(message: string, public status: number, public code?: string) {
    super(message);
    this.name = 'ApiError';
  }
}

class TimeoutError extends Error {
  constructor(message: string = 'Operation timed out') {
    super(message);
    this.name = 'TimeoutError';
  }
}
```

### Error Handling Utilities

#### createErrorHandler

**Description**: Creates a standardized error handler function.

**Category**: Error Handling

**Signature**:
```typescript
function createErrorHandler<T extends Error = Error>(
  handler: (error: T) => void
): (error: T) => void
```

#### tryAsync

**Description**: Safely executes an async function and returns result or error.

**Category**: Error Handling

**Signature**:
```typescript
type AsyncResult<T> = { success: true; data: T } | { success: false; error: Error };

function tryAsync<T>(fn: () => Promise<T>): Promise<AsyncResult<T>>
```

**Example**:
```typescript
const result = await tryAsync(() => apiRequest('/data'));
if (result.success) {
  console.log('Data:', result.data);
} else {
  console.error('Error:', result.error.message);
}
```

## Testing Functions

### Test Utilities

#### mockFunction

**Description**: Creates a mock function for testing.

**Category**: Testing

**Signature**:
```typescript
interface MockFunction<T extends (...args: any[]) => any> {
  (...args: Parameters<T>): ReturnType<T>;
  calls: Parameters<T>[];
  results: ReturnType<T>[];
  mockReturnValue(value: ReturnType<T>): void;
  mockImplementation(fn: T): void;
  reset(): void;
}

function mockFunction<T extends (...args: any[]) => any>(): MockFunction<T>
```

**Example**:
```typescript
const mockApi = mockFunction<(id: string) => Promise<User>>();
mockApi.mockReturnValue(Promise.resolve({ id: '1', name: 'John' }));

const user = await mockApi('1');
console.log(mockApi.calls); // [['1']]
```

#### createTestFixture

**Description**: Creates test data fixtures for consistent testing.

**Category**: Testing

**Signature**:
```typescript
function createTestFixture<T>(factory: () => T): () => T
```

**Example**:
```typescript
const createUser = createTestFixture(() => ({
  id: Math.random().toString(),
  name: 'Test User',
  email: 'test@example.com',
  createdAt: new Date()
}));

const user1 = createUser();
const user2 = createUser();
```

---

**Note**: This documentation serves as a template and will be updated as actual functions are implemented in the project. Each function should follow the documented patterns and include comprehensive examples and type definitions.