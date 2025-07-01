# Component Documentation

## Overview

This document provides comprehensive documentation for all components in the `tarea-1` project. Components are reusable UI elements that encapsulate functionality and presentation.

## Table of Contents

- [Component Guidelines](#component-guidelines)
- [Component Templates](#component-templates)
- [React Components](#react-components)
- [Web Components](#web-components)
- [Vue Components](#vue-components)
- [Angular Components](#angular-components)
- [Styling Guidelines](#styling-guidelines)
- [Testing Components](#testing-components)

## Component Guidelines

### Naming Conventions
- Use PascalCase for component names (e.g., `UserProfile`, `NavigationBar`)
- Use descriptive names that clearly indicate the component's purpose
- Prefix with the domain when needed (e.g., `AuthButton`, `PaymentForm`)

### File Structure
```
components/
├── Button/
│   ├── Button.tsx         # Main component
│   ├── Button.test.tsx    # Tests
│   ├── Button.stories.tsx # Storybook stories
│   ├── Button.module.css  # Styles
│   └── index.ts           # Exports
└── UserProfile/
    ├── UserProfile.tsx
    ├── UserProfile.test.tsx
    ├── UserProfile.stories.tsx
    ├── UserProfile.module.css
    └── index.ts
```

### Documentation Format
Each component should include:
- **Description**: What the component does
- **Props/Attributes**: All configurable properties
- **Events**: Events the component emits
- **Usage Examples**: Code examples showing how to use
- **Accessibility**: ARIA labels and keyboard navigation
- **Styling**: CSS classes and customization options

## Component Templates

### Basic Component Template

#### ComponentName

**Description**: Brief description of what this component does and when to use it.

**Type**: `Presentational` | `Container` | `Layout` | `Form` | `Navigation` | `Data Display`

**Props/Attributes**:
| Name | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| title | string | "" | Yes | The main title text |
| variant | 'primary' \| 'secondary' | 'primary' | No | Visual style variant |
| disabled | boolean | false | No | Whether the component is disabled |
| onClick | function | undefined | No | Callback when component is clicked |
| children | ReactNode | undefined | No | Child elements to render |

**Events**:
| Event | Payload | Description |
|-------|---------|-------------|
| click | MouseEvent | Fired when component is clicked |
| focus | FocusEvent | Fired when component receives focus |
| blur | FocusEvent | Fired when component loses focus |

**Usage**:
```tsx
import { ComponentName } from './components/ComponentName';

// Basic usage
<ComponentName title="Hello World" />

// With all props
<ComponentName
  title="Click me"
  variant="secondary"
  disabled={false}
  onClick={() => console.log('Clicked!')}
>
  <span>Child content</span>
</ComponentName>
```

**Accessibility**:
- Supports keyboard navigation with Tab/Enter/Space
- ARIA labels provided for screen readers
- Color contrast meets WCAG AA standards
- Focus management handled properly

**Styling**:
```css
/* Available CSS classes */
.component-name { }           /* Base styles */
.component-name--primary { }  /* Primary variant */
.component-name--secondary { } /* Secondary variant */
.component-name--disabled { } /* Disabled state */

/* CSS Custom Properties for theming */
--component-bg-color: #ffffff;
--component-text-color: #000000;
--component-border-radius: 4px;
```

**Examples**:

*Basic Button Example*:
```tsx
<ComponentName 
  title="Submit"
  variant="primary"
  onClick={handleSubmit}
/>
```

*Disabled State*:
```tsx
<ComponentName 
  title="Loading..."
  disabled={true}
/>
```

*With Custom Styling*:
```tsx
<ComponentName 
  title="Custom Button"
  style={{
    '--component-bg-color': '#ff6b6b',
    '--component-text-color': '#ffffff'
  }}
/>
```

## React Components

### React Component Template

```tsx
import React, { useState, useEffect, forwardRef } from 'react';
import { ComponentNameProps } from './types';
import styles from './ComponentName.module.css';

/**
 * ComponentName - Brief description
 * 
 * @param props - Component properties
 * @returns JSX element
 */
export const ComponentName = forwardRef<HTMLDivElement, ComponentNameProps>(
  ({ title, variant = 'primary', disabled = false, onClick, children, ...rest }, ref) => {
    const [isLoading, setIsLoading] = useState(false);

    useEffect(() => {
      // Component lifecycle logic
    }, []);

    const handleClick = (event: React.MouseEvent) => {
      if (disabled) return;
      onClick?.(event);
    };

    const classNames = [
      styles.componentName,
      styles[`componentName--${variant}`],
      disabled && styles['componentName--disabled']
    ].filter(Boolean).join(' ');

    return (
      <div
        ref={ref}
        className={classNames}
        onClick={handleClick}
        role="button"
        tabIndex={disabled ? -1 : 0}
        aria-disabled={disabled}
        {...rest}
      >
        <h3>{title}</h3>
        {children}
      </div>
    );
  }
);

ComponentName.displayName = 'ComponentName';
```

### React Hooks Template

```tsx
import { useState, useEffect, useCallback } from 'react';

/**
 * useComponentName - Custom hook for component logic
 * 
 * @param options - Hook configuration options
 * @returns Hook state and methods
 */
export const useComponentName = (options: UseComponentNameOptions) => {
  const [state, setState] = useState(options.initialState);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error | null>(null);

  const handleAction = useCallback(async (data: any) => {
    setLoading(true);
    setError(null);
    
    try {
      // Async logic here
      setState(newState);
    } catch (err) {
      setError(err as Error);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    // Effect logic
  }, [options]);

  return {
    state,
    loading,
    error,
    handleAction
  };
};
```

## Web Components

### Web Component Template

```typescript
class ComponentName extends HTMLElement {
  private _title: string = '';
  private _disabled: boolean = false;

  static get observedAttributes() {
    return ['title', 'disabled', 'variant'];
  }

  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
    this.render();
    this.setupEventListeners();
  }

  get title(): string {
    return this._title;
  }

  set title(value: string) {
    this._title = value;
    this.setAttribute('title', value);
    this.render();
  }

  get disabled(): boolean {
    return this._disabled;
  }

  set disabled(value: boolean) {
    this._disabled = value;
    if (value) {
      this.setAttribute('disabled', '');
    } else {
      this.removeAttribute('disabled');
    }
    this.render();
  }

  attributeChangedCallback(name: string, oldValue: string, newValue: string) {
    switch (name) {
      case 'title':
        this._title = newValue;
        break;
      case 'disabled':
        this._disabled = newValue !== null;
        break;
    }
    this.render();
  }

  connectedCallback() {
    this.render();
  }

  private setupEventListeners() {
    this.addEventListener('click', this.handleClick.bind(this));
    this.addEventListener('keydown', this.handleKeydown.bind(this));
  }

  private handleClick(event: Event) {
    if (this.disabled) return;
    
    this.dispatchEvent(new CustomEvent('component-click', {
      detail: { originalEvent: event },
      bubbles: true
    }));
  }

  private handleKeydown(event: KeyboardEvent) {
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      this.handleClick(event);
    }
  }

  private render() {
    if (!this.shadowRoot) return;

    this.shadowRoot.innerHTML = `
      <style>
        :host {
          display: inline-block;
          background: var(--component-bg-color, #f0f0f0);
          border: 1px solid var(--component-border-color, #ccc);
          border-radius: var(--component-border-radius, 4px);
          padding: var(--component-padding, 8px 16px);
          cursor: pointer;
          font-family: inherit;
        }

        :host([disabled]) {
          opacity: 0.6;
          cursor: not-allowed;
        }

        .title {
          margin: 0;
          font-size: var(--component-font-size, 14px);
        }
      </style>
      
      <h3 class="title">${this.title}</h3>
      <slot></slot>
    `;
  }
}

// Register the custom element
customElements.define('component-name', ComponentName);

// Export for TypeScript
export { ComponentName };
```

**Usage**:
```html
<!-- Basic usage -->
<component-name title="Hello World"></component-name>

<!-- With attributes -->
<component-name 
  title="Click me" 
  variant="primary"
  disabled
>
  <span>Child content</span>
</component-name>

<!-- JavaScript usage -->
<script>
  const component = document.querySelector('component-name');
  component.addEventListener('component-click', (event) => {
    console.log('Component clicked!', event.detail);
  });
</script>
```

## Vue Components

### Vue 3 Composition API Template

```vue
<template>
  <div 
    :class="componentClasses"
    @click="handleClick"
    @keydown="handleKeydown"
    :tabindex="disabled ? -1 : 0"
    :aria-disabled="disabled"
    role="button"
  >
    <h3>{{ title }}</h3>
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { computed, onMounted, onUnmounted } from 'vue';

interface Props {
  title: string;
  variant?: 'primary' | 'secondary';
  disabled?: boolean;
}

interface Emits {
  click: [event: MouseEvent];
  focus: [event: FocusEvent];
  blur: [event: FocusEvent];
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'primary',
  disabled: false
});

const emit = defineEmits<Emits>();

const componentClasses = computed(() => [
  'component-name',
  `component-name--${props.variant}`,
  { 'component-name--disabled': props.disabled }
]);

const handleClick = (event: MouseEvent) => {
  if (props.disabled) return;
  emit('click', event);
};

const handleKeydown = (event: KeyboardEvent) => {
  if (event.key === 'Enter' || event.key === ' ') {
    event.preventDefault();
    handleClick(event as any);
  }
};

onMounted(() => {
  // Component mounted logic
});

onUnmounted(() => {
  // Cleanup logic
});
</script>

<style scoped>
.component-name {
  display: inline-block;
  background: var(--component-bg-color, #f0f0f0);
  border: 1px solid var(--component-border-color, #ccc);
  border-radius: var(--component-border-radius, 4px);
  padding: var(--component-padding, 8px 16px);
  cursor: pointer;
}

.component-name--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.component-name--primary {
  background: var(--primary-color, #007bff);
  color: white;
}

.component-name--secondary {
  background: var(--secondary-color, #6c757d);
  color: white;
}
</style>
```

**Usage**:
```vue
<template>
  <ComponentName 
    title="Click me"
    variant="primary"
    :disabled="false"
    @click="handleComponentClick"
  >
    <span>Child content</span>
  </ComponentName>
</template>

<script setup>
import ComponentName from './components/ComponentName.vue';

const handleComponentClick = (event) => {
  console.log('Component clicked!', event);
};
</script>
```

## Angular Components

### Angular Component Template

```typescript
// component-name.component.ts
import { 
  Component, 
  Input, 
  Output, 
  EventEmitter, 
  OnInit, 
  OnDestroy,
  HostListener,
  HostBinding
} from '@angular/core';

export type ComponentVariant = 'primary' | 'secondary';

@Component({
  selector: 'app-component-name',
  templateUrl: './component-name.component.html',
  styleUrls: ['./component-name.component.scss']
})
export class ComponentNameComponent implements OnInit, OnDestroy {
  @Input() title: string = '';
  @Input() variant: ComponentVariant = 'primary';
  @Input() disabled: boolean = false;

  @Output() click = new EventEmitter<MouseEvent>();
  @Output() focus = new EventEmitter<FocusEvent>();
  @Output() blur = new EventEmitter<FocusEvent>();

  @HostBinding('class') get cssClasses() {
    return [
      'component-name',
      `component-name--${this.variant}`,
      this.disabled ? 'component-name--disabled' : ''
    ].filter(Boolean).join(' ');
  }

  @HostBinding('attr.tabindex') get tabIndex() {
    return this.disabled ? -1 : 0;
  }

  @HostBinding('attr.aria-disabled') get ariaDisabled() {
    return this.disabled;
  }

  @HostListener('click', ['$event'])
  onClick(event: MouseEvent) {
    if (this.disabled) return;
    this.click.emit(event);
  }

  @HostListener('keydown', ['$event'])
  onKeydown(event: KeyboardEvent) {
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      this.onClick(event as any);
    }
  }

  @HostListener('focus', ['$event'])
  onFocus(event: FocusEvent) {
    this.focus.emit(event);
  }

  @HostListener('blur', ['$event'])
  onBlur(event: FocusEvent) {
    this.blur.emit(event);
  }

  ngOnInit() {
    // Component initialization
  }

  ngOnDestroy() {
    // Cleanup logic
  }
}
```

```html
<!-- component-name.component.html -->
<div role="button">
  <h3>{{ title }}</h3>
  <ng-content></ng-content>
</div>
```

```scss
/* component-name.component.scss */
:host {
  display: inline-block;
  background: var(--component-bg-color, #f0f0f0);
  border: 1px solid var(--component-border-color, #ccc);
  border-radius: var(--component-border-radius, 4px);
  padding: var(--component-padding, 8px 16px);
  cursor: pointer;
  font-family: inherit;

  &.component-name--disabled {
    opacity: 0.6;
    cursor: not-allowed;
  }

  &.component-name--primary {
    background: var(--primary-color, #007bff);
    color: white;
  }

  &.component-name--secondary {
    background: var(--secondary-color, #6c757d);
    color: white;
  }
}

h3 {
  margin: 0;
  font-size: var(--component-font-size, 14px);
}
```

**Usage**:
```html
<!-- Basic usage -->
<app-component-name title="Hello World"></app-component-name>

<!-- With all properties -->
<app-component-name 
  title="Click me"
  variant="primary"
  [disabled]="false"
  (click)="handleClick($event)"
  (focus)="handleFocus($event)"
>
  <span>Child content</span>
</app-component-name>
```

## Styling Guidelines

### CSS Custom Properties
Use CSS custom properties for theming:

```css
:root {
  /* Color system */
  --primary-color: #007bff;
  --secondary-color: #6c757d;
  --success-color: #28a745;
  --warning-color: #ffc107;
  --danger-color: #dc3545;
  
  /* Typography */
  --font-family: 'Segoe UI', system-ui, sans-serif;
  --font-size-sm: 12px;
  --font-size-md: 14px;
  --font-size-lg: 16px;
  
  /* Spacing */
  --space-xs: 4px;
  --space-sm: 8px;
  --space-md: 16px;
  --space-lg: 24px;
  --space-xl: 32px;
  
  /* Border radius */
  --border-radius-sm: 2px;
  --border-radius-md: 4px;
  --border-radius-lg: 8px;
  
  /* Shadows */
  --shadow-sm: 0 1px 2px rgba(0,0,0,0.1);
  --shadow-md: 0 2px 4px rgba(0,0,0,0.1);
  --shadow-lg: 0 4px 8px rgba(0,0,0,0.15);
}
```

### Component-specific Properties
```css
.component-name {
  /* Use semantic names */
  background: var(--component-bg, var(--primary-color));
  color: var(--component-text, white);
  border-radius: var(--component-radius, var(--border-radius-md));
  padding: var(--component-padding, var(--space-sm) var(--space-md));
  
  /* State modifiers */
  &:hover {
    background: var(--component-bg-hover, var(--primary-color-hover));
  }
  
  &:focus {
    outline: 2px solid var(--focus-color, var(--primary-color));
    outline-offset: 2px;
  }
  
  &:disabled {
    opacity: var(--disabled-opacity, 0.6);
    cursor: not-allowed;
  }
}
```

## Testing Components

### React Testing Library Example
```tsx
import { render, screen, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { ComponentName } from './ComponentName';

describe('ComponentName', () => {
  it('renders with title', () => {
    render(<ComponentName title="Test Title" />);
    expect(screen.getByText('Test Title')).toBeInTheDocument();
  });

  it('calls onClick when clicked', async () => {
    const handleClick = jest.fn();
    render(<ComponentName title="Clickable" onClick={handleClick} />);
    
    await userEvent.click(screen.getByRole('button'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('does not call onClick when disabled', async () => {
    const handleClick = jest.fn();
    render(<ComponentName title="Disabled" disabled onClick={handleClick} />);
    
    await userEvent.click(screen.getByRole('button'));
    expect(handleClick).not.toHaveBeenCalled();
  });

  it('supports keyboard navigation', async () => {
    const handleClick = jest.fn();
    render(<ComponentName title="Keyboard" onClick={handleClick} />);
    
    const button = screen.getByRole('button');
    button.focus();
    await userEvent.keyboard('{Enter}');
    expect(handleClick).toHaveBeenCalledTimes(1);
  });
});
```

### Vue Test Utils Example
```typescript
import { mount } from '@vue/test-utils';
import ComponentName from './ComponentName.vue';

describe('ComponentName', () => {
  it('renders title prop', () => {
    const wrapper = mount(ComponentName, {
      props: { title: 'Test Title' }
    });
    
    expect(wrapper.text()).toContain('Test Title');
  });

  it('emits click event when clicked', async () => {
    const wrapper = mount(ComponentName, {
      props: { title: 'Clickable' }
    });
    
    await wrapper.trigger('click');
    expect(wrapper.emitted('click')).toHaveLength(1);
  });

  it('does not emit click when disabled', async () => {
    const wrapper = mount(ComponentName, {
      props: { title: 'Disabled', disabled: true }
    });
    
    await wrapper.trigger('click');
    expect(wrapper.emitted('click')).toBeFalsy();
  });
});
```

### Angular Testing Example
```typescript
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ComponentNameComponent } from './component-name.component';

describe('ComponentNameComponent', () => {
  let component: ComponentNameComponent;
  let fixture: ComponentFixture<ComponentNameComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ComponentNameComponent]
    }).compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ComponentNameComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should render title', () => {
    component.title = 'Test Title';
    fixture.detectChanges();
    
    const compiled = fixture.nativeElement;
    expect(compiled.querySelector('h3').textContent).toContain('Test Title');
  });

  it('should emit click event', () => {
    spyOn(component.click, 'emit');
    
    const compiled = fixture.nativeElement;
    compiled.click();
    
    expect(component.click.emit).toHaveBeenCalled();
  });
});
```

---

**Note**: This documentation will be updated as actual components are added to the project. Each section provides templates and examples that can be adapted for specific component implementations.