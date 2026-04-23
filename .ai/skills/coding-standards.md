---
name: coding-standards
description: Universal coding standards for TypeScript/JavaScript/React, PHP (PSR-12/Laravel), Blade templates, and HTML5 — naming, KISS/DRY/YAGNI, formatting, error handling, and file organization.
origin: ECC
---

# Coding Standards & Best Practices

Universal coding standards applicable across all projects.

## When to Activate

- Starting a new project or module
- Reviewing code for quality and maintainability
- Refactoring existing code to follow conventions
- Enforcing naming, formatting, or structural consistency
- Setting up linting, formatting, or type-checking rules
- Onboarding new contributors to coding conventions

## Code Quality Principles

### 1. Readability First
- Code is read more than written
- Clear variable and function names
- Self-documenting code preferred over comments
- Consistent formatting

### 2. KISS (Keep It Simple, Stupid)
- Simplest solution that works
- Avoid over-engineering
- No premature optimization
- Easy to understand > clever code

### 3. DRY (Don't Repeat Yourself)
- Extract common logic into functions
- Create reusable components
- Share utilities across modules
- Avoid copy-paste programming

### 4. YAGNI (You Aren't Gonna Need It)
- Don't build features before they're needed
- Avoid speculative generality
- Add complexity only when required
- Start simple, refactor when needed

## TypeScript/JavaScript Standards

### Variable Naming

```typescript
// PASS: GOOD: Descriptive names
const marketSearchQuery = 'election'
const isUserAuthenticated = true
const totalRevenue = 1000

// FAIL: BAD: Unclear names
const q = 'election'
const flag = true
const x = 1000
```

### Function Naming

```typescript
// PASS: GOOD: Verb-noun pattern
async function fetchMarketData(marketId: string) { }
function calculateSimilarity(a: number[], b: number[]) { }
function isValidEmail(email: string): boolean { }

// FAIL: BAD: Unclear or noun-only
async function market(id: string) { }
function similarity(a, b) { }
function email(e) { }
```

### Immutability Pattern (CRITICAL)

```typescript
// PASS: ALWAYS use spread operator
const updatedUser = {
  ...user,
  name: 'New Name'
}

const updatedArray = [...items, newItem]

// FAIL: NEVER mutate directly
user.name = 'New Name'  // BAD
items.push(newItem)     // BAD
```

### Error Handling

```typescript
// PASS: GOOD: Comprehensive error handling
async function fetchData(url: string) {
  try {
    const response = await fetch(url)

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}: ${response.statusText}`)
    }

    return await response.json()
  } catch (error) {
    console.error('Fetch failed:', error)
    throw new Error('Failed to fetch data')
  }
}

// FAIL: BAD: No error handling
async function fetchData(url) {
  const response = await fetch(url)
  return response.json()
}
```

### Async/Await Best Practices

```typescript
// PASS: GOOD: Parallel execution when possible
const [users, markets, stats] = await Promise.all([
  fetchUsers(),
  fetchMarkets(),
  fetchStats()
])

// FAIL: BAD: Sequential when unnecessary
const users = await fetchUsers()
const markets = await fetchMarkets()
const stats = await fetchStats()
```

### Type Safety

```typescript
// PASS: GOOD: Proper types
interface Market {
  id: string
  name: string
  status: 'active' | 'resolved' | 'closed'
  created_at: Date
}

function getMarket(id: string): Promise<Market> {
  // Implementation
}

// FAIL: BAD: Using 'any'
function getMarket(id: any): Promise<any> {
  // Implementation
}
```

## React Best Practices

### Component Structure

```typescript
// PASS: GOOD: Functional component with types
interface ButtonProps {
  children: React.ReactNode
  onClick: () => void
  disabled?: boolean
  variant?: 'primary' | 'secondary'
}

export function Button({
  children,
  onClick,
  disabled = false,
  variant = 'primary'
}: ButtonProps) {
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`btn btn-${variant}`}
    >
      {children}
    </button>
  )
}

// FAIL: BAD: No types, unclear structure
export function Button(props) {
  return <button onClick={props.onClick}>{props.children}</button>
}
```

### Custom Hooks

```typescript
// PASS: GOOD: Reusable custom hook
export function useDebounce<T>(value: T, delay: number): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value)

  useEffect(() => {
    const handler = setTimeout(() => {
      setDebouncedValue(value)
    }, delay)

    return () => clearTimeout(handler)
  }, [value, delay])

  return debouncedValue
}

// Usage
const debouncedQuery = useDebounce(searchQuery, 500)
```

### State Management

```typescript
// PASS: GOOD: Proper state updates
const [count, setCount] = useState(0)

// Functional update for state based on previous state
setCount(prev => prev + 1)

// FAIL: BAD: Direct state reference
setCount(count + 1)  // Can be stale in async scenarios
```

### Conditional Rendering

```typescript
// PASS: GOOD: Clear conditional rendering
{isLoading && <Spinner />}
{error && <ErrorMessage error={error} />}
{data && <DataDisplay data={data} />}

// FAIL: BAD: Ternary hell
{isLoading ? <Spinner /> : error ? <ErrorMessage error={error} /> : data ? <DataDisplay data={data} /> : null}
```

## API Design Standards

### REST API Conventions

```
GET    /api/markets              # List all markets
GET    /api/markets/:id          # Get specific market
POST   /api/markets              # Create new market
PUT    /api/markets/:id          # Update market (full)
PATCH  /api/markets/:id          # Update market (partial)
DELETE /api/markets/:id          # Delete market

# Query parameters for filtering
GET /api/markets?status=active&limit=10&offset=0
```

### Response Format

```typescript
// PASS: GOOD: Consistent response structure
interface ApiResponse<T> {
  success: boolean
  data?: T
  error?: string
  meta?: {
    total: number
    page: number
    limit: number
  }
}

// Success response
return NextResponse.json({
  success: true,
  data: markets,
  meta: { total: 100, page: 1, limit: 10 }
})

// Error response
return NextResponse.json({
  success: false,
  error: 'Invalid request'
}, { status: 400 })
```

### Input Validation

```typescript
import { z } from 'zod'

// PASS: GOOD: Schema validation
const CreateMarketSchema = z.object({
  name: z.string().min(1).max(200),
  description: z.string().min(1).max(2000),
  endDate: z.string().datetime(),
  categories: z.array(z.string()).min(1)
})

export async function POST(request: Request) {
  const body = await request.json()

  try {
    const validated = CreateMarketSchema.parse(body)
    // Proceed with validated data
  } catch (error) {
    if (error instanceof z.ZodError) {
      return NextResponse.json({
        success: false,
        error: 'Validation failed',
        details: error.errors
      }, { status: 400 })
    }
  }
}
```

## File Organization

### Project Structure

```
src/
├── app/                    # Next.js App Router
│   ├── api/               # API routes
│   ├── markets/           # Market pages
│   └── (auth)/           # Auth pages (route groups)
├── components/            # React components
│   ├── ui/               # Generic UI components
│   ├── forms/            # Form components
│   └── layouts/          # Layout components
├── hooks/                # Custom React hooks
├── lib/                  # Utilities and configs
│   ├── api/             # API clients
│   ├── utils/           # Helper functions
│   └── constants/       # Constants
├── types/                # TypeScript types
└── styles/              # Global styles
```

### File Naming

```
components/Button.tsx          # PascalCase for components
hooks/useAuth.ts              # camelCase with 'use' prefix
lib/formatDate.ts             # camelCase for utilities
types/market.types.ts         # camelCase with .types suffix
```

## Comments & Documentation

### When to Comment

```typescript
// PASS: GOOD: Explain WHY, not WHAT
// Use exponential backoff to avoid overwhelming the API during outages
const delay = Math.min(1000 * Math.pow(2, retryCount), 30000)

// Deliberately using mutation here for performance with large arrays
items.push(newItem)

// FAIL: BAD: Stating the obvious
// Increment counter by 1
count++

// Set name to user's name
name = user.name
```

### JSDoc for Public APIs

```typescript
/**
 * Searches markets using semantic similarity.
 *
 * @param query - Natural language search query
 * @param limit - Maximum number of results (default: 10)
 * @returns Array of markets sorted by similarity score
 * @throws {Error} If OpenAI API fails or Redis unavailable
 *
 * @example
 * ```typescript
 * const results = await searchMarkets('election', 5)
 * console.log(results[0].name) // "Trump vs Biden"
 * ```
 */
export async function searchMarkets(
  query: string,
  limit: number = 10
): Promise<Market[]> {
  // Implementation
}
```

## Performance Best Practices

### Memoization

```typescript
import { useMemo, useCallback } from 'react'

// PASS: GOOD: Memoize expensive computations
const sortedMarkets = useMemo(() => {
  return markets.sort((a, b) => b.volume - a.volume)
}, [markets])

// PASS: GOOD: Memoize callbacks
const handleSearch = useCallback((query: string) => {
  setSearchQuery(query)
}, [])
```

### Lazy Loading

```typescript
import { lazy, Suspense } from 'react'

// PASS: GOOD: Lazy load heavy components
const HeavyChart = lazy(() => import('./HeavyChart'))

export function Dashboard() {
  return (
    <Suspense fallback={<Spinner />}>
      <HeavyChart />
    </Suspense>
  )
}
```

### Database Queries

```typescript
// PASS: GOOD: Select only needed columns
const { data } = await supabase
  .from('markets')
  .select('id, name, status')
  .limit(10)

// FAIL: BAD: Select everything
const { data } = await supabase
  .from('markets')
  .select('*')
```

## Testing Standards

### Test Structure (AAA Pattern)

```typescript
test('calculates similarity correctly', () => {
  // Arrange
  const vector1 = [1, 0, 0]
  const vector2 = [0, 1, 0]

  // Act
  const similarity = calculateCosineSimilarity(vector1, vector2)

  // Assert
  expect(similarity).toBe(0)
})
```

### Test Naming

```typescript
// PASS: GOOD: Descriptive test names
test('returns empty array when no markets match query', () => { })
test('throws error when OpenAI API key is missing', () => { })
test('falls back to substring search when Redis unavailable', () => { })

// FAIL: BAD: Vague test names
test('works', () => { })
test('test search', () => { })
```

## Code Smell Detection

Watch for these anti-patterns:

### 1. Long Functions
```typescript
// FAIL: BAD: Function > 50 lines
function processMarketData() {
  // 100 lines of code
}

// PASS: GOOD: Split into smaller functions
function processMarketData() {
  const validated = validateData()
  const transformed = transformData(validated)
  return saveData(transformed)
}
```

### 2. Deep Nesting
```typescript
// FAIL: BAD: 5+ levels of nesting
if (user) {
  if (user.isAdmin) {
    if (market) {
      if (market.isActive) {
        if (hasPermission) {
          // Do something
        }
      }
    }
  }
}

// PASS: GOOD: Early returns
if (!user) return
if (!user.isAdmin) return
if (!market) return
if (!market.isActive) return
if (!hasPermission) return

// Do something
```

### 3. Magic Numbers
```typescript
// FAIL: BAD: Unexplained numbers
if (retryCount > 3) { }
setTimeout(callback, 500)

// PASS: GOOD: Named constants
const MAX_RETRIES = 3
const DEBOUNCE_DELAY_MS = 500

if (retryCount > MAX_RETRIES) { }
setTimeout(callback, DEBOUNCE_DELAY_MS)
```

**Remember**: Code quality is not negotiable. Clear, maintainable code enables rapid development and confident refactoring.

---

## PHP Standards (PSR-12 / Laravel)

### Naming Conventions

```php
// Classes: PascalCase
class UserRepository {}
class OrderService {}

// Methods and variables: camelCase
public function findByEmail(string $email): ?User {}
$activeUsers = [];

// Constants: UPPER_SNAKE_CASE
const MAX_LOGIN_ATTEMPTS = 5;
define('APP_VERSION', '1.0.0');

// Database columns / env keys: snake_case
// users.created_at, DB_HOST, APP_KEY
```

### PSR-12 Essentials

```php
<?php

declare(strict_types=1);  // Always declare at top of file

namespace App\Services;

use App\Models\User;
use App\Repositories\UserRepository;

class UserService
{
    public function __construct(
        private readonly UserRepository $users,
    ) {}

    public function findActive(): array
    {
        return $this->users->findWhere(['is_active' => true]);
    }
}
```

### Type Declarations (PHP 8+)

```php
// GOOD: strict types throughout
function calculateTotal(int $quantity, float $price): float
{
    return $quantity * $price;
}

// GOOD: nullable return
function findUser(int $id): ?User
{
    return User::find($id);
}

// GOOD: union types
function process(int|string $id): void {}

// BAD: no type hints
function calculateTotal($qty, $price) {
    return $qty * $price;
}
```

### Error Handling

```php
// GOOD: specific exception types
try {
    $user = $this->users->findOrFail($id);
} catch (ModelNotFoundException $e) {
    throw new UserNotFoundException("User {$id} not found", previous: $e);
} catch (\Exception $e) {
    Log::error('Unexpected error in UserService::find', [
        'id'    => $id,
        'error' => $e->getMessage(),
    ]);
    throw $e;
}

// BAD: swallowing exceptions silently
try {
    $user = $this->users->findOrFail($id);
} catch (\Exception $e) {
    // silent catch
}
```

### Laravel Service Layer Pattern

```php
// app/Services/OrderService.php
class OrderService
{
    public function __construct(
        private readonly OrderRepository $orders,
        private readonly InventoryService $inventory,
    ) {}

    public function place(User $user, array $items): Order
    {
        return DB::transaction(function () use ($user, $items) {
            foreach ($items as $item) {
                $this->inventory->reserve($item['product_id'], $item['qty']);
            }

            return $this->orders->create([
                'user_id' => $user->id,
                'items'   => $items,
                'total'   => $this->calcTotal($items),
            ]);
        });
    }

    private function calcTotal(array $items): float
    {
        return collect($items)->sum(fn($i) => $i['price'] * $i['qty']);
    }
}
```

### Laravel Repository Pattern

```php
// app/Repositories/UserRepository.php
interface UserRepositoryInterface
{
    public function find(int $id): ?User;
    public function findByEmail(string $email): ?User;
    public function create(array $data): User;
}

class EloquentUserRepository implements UserRepositoryInterface
{
    public function find(int $id): ?User
    {
        return User::find($id);
    }

    public function findByEmail(string $email): ?User
    {
        return User::where('email', $email)->first();
    }

    public function create(array $data): User
    {
        return User::create($data);
    }
}
```

---

## Blade Template Standards (Laravel)

### Structure

```blade
{{-- resources/views/users/show.blade.php --}}
@extends('layouts.app')

@section('title', $user->name)

@section('content')
    <div class="container">
        @include('partials.breadcrumb', ['items' => $breadcrumbs])

        <x-card>
            <x-slot:header>{{ $user->name }}</x-slot:header>

            @if ($user->isActive())
                <x-badge variant="success">Active</x-badge>
            @else
                <x-badge variant="danger">Inactive</x-badge>
            @endif

            {{-- Loop --}}
            @forelse ($user->orders as $order)
                <x-order-row :order="$order" />
            @empty
                <p>No orders yet.</p>
            @endforelse
        </x-card>
    </div>
@endsection
```

### Blade Components

```php
// app/View/Components/Card.php
class Card extends Component
{
    public function __construct(
        public string $variant = 'default',
    ) {}

    public function render(): View
    {
        return view('components.card');
    }
}
```

```blade
{{-- resources/views/components/card.blade.php --}}
<div {{ $attributes->class(['card', "card-{$variant}"]) }}>
    @isset($header)
        <div class="card-header">{{ $header }}</div>
    @endisset
    <div class="card-body">{{ $slot }}</div>
</div>
```

### Security in Blade

```blade
{{-- GOOD: escaped output (XSS safe) --}}
{{ $user->name }}

{{-- BAD: unescaped — only use for trusted HTML --}}
{!! $user->bio !!}

{{-- GOOD: CSRF on all forms --}}
<form method="POST" action="/orders">
    @csrf
    @method('PUT')
    ...
</form>

{{-- GOOD: authorized check before showing sensitive UI --}}
@can('delete', $post)
    <button>Delete</button>
@endcan
```

### Passing Data

```php
// Controller: always pass typed/validated data
public function show(User $user): View
{
    return view('users.show', [
        'user'   => $user->load('orders'),
        'stats'  => $this->stats->forUser($user),
    ]);
}
```

---

## HTML5 Best Practices

### Semantic Structure

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Title — Site Name</title>
    <meta name="description" content="Page description for SEO, max 160 chars.">
</head>
<body>
    <header>
        <nav aria-label="Main navigation">
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="/about">About</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <article>
            <h1>Article Title</h1>
            <p>Content...</p>
        </article>

        <aside aria-label="Related links">
            <h2>Related</h2>
        </aside>
    </main>

    <footer>
        <p>&copy; 2024 Company Name</p>
    </footer>
</body>
</html>
```

### Accessible Forms

```html
<!-- GOOD: label always linked to input -->
<form method="POST" action="/register" novalidate>
    <div class="form-group">
        <label for="email">Email address <span aria-hidden="true">*</span></label>
        <input
            type="email"
            id="email"
            name="email"
            required
            autocomplete="email"
            aria-describedby="email-hint email-error"
        >
        <p id="email-hint" class="hint">We will never share your email.</p>
        <p id="email-error" class="error" role="alert" hidden></p>
    </div>

    <button type="submit">Register</button>
</form>

<!-- BAD: input without label, placeholder as label substitute -->
<input type="email" placeholder="Email">
```

### Images

```html
<!-- GOOD: always provide meaningful alt text -->
<img src="product.jpg" alt="Red running shoes, size 42" width="400" height="300">

<!-- GOOD: decorative images use empty alt -->
<img src="divider.png" alt="" role="presentation">

<!-- GOOD: responsive images -->
<img
    src="hero-800.jpg"
    srcset="hero-400.jpg 400w, hero-800.jpg 800w, hero-1200.jpg 1200w"
    sizes="(max-width: 600px) 400px, (max-width: 1000px) 800px, 1200px"
    alt="Team working together"
    loading="lazy"
>
```

### Performance

```html
<!-- Preload critical assets -->
<link rel="preload" href="/fonts/main.woff2" as="font" type="font/woff2" crossorigin>
<link rel="preload" href="/css/critical.css" as="style">

<!-- Defer non-critical JS -->
<script src="/js/analytics.js" defer></script>
<script src="/js/chat-widget.js" async></script>

<!-- Preconnect to external domains -->
<link rel="preconnect" href="https://fonts.googleapis.com">
```

### Vanilla JS — Event Handling

```javascript
// GOOD: event delegation instead of per-element listeners
document.querySelector('#list').addEventListener('click', (event) => {
    const item = event.target.closest('[data-id]');
    if (!item) return;
    handleItemClick(item.dataset.id);
});

// GOOD: cleanup listeners to avoid memory leaks
const controller = new AbortController();
document.addEventListener('keydown', handleKeydown, { signal: controller.signal });
// Later:
controller.abort(); // removes the listener
```
