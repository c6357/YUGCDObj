# GCDObjC

GCDObjC is an Objective-C wrapper for the most commonly used features of Grand Central Dispatch.  It has four main aims:

* Organize the flat C API into appropriate classes.
* Use intention-revealing names to distinguish between synchronous and asynchronous functions. 
* Use more convenient arguments such as time intervals.
* Add convenience methods.

**A Swift port is at [GCDSwift](https://github.com/mjmsmith/gcdswift).**

## Usage

__GCDObjC__ requires ARC and iOS 6.0.  (Prior to 6.0, dispatch objects were not considered Objective-C objects, and therefore required manual memory management.)

__GCDObjC.h__ is the only header file that needs to be imported.

For usage examples, see [GCDObjCTests.m](https://github.com/mjmsmith/gcdobjc/blob/master/GCDObjCTests/GCDObjCTests.m).

Install via CocoaPods:

```ruby
pod "GCDObjC"
```

## GCDQueue

Queues are implemented in the __GCDQueue__ class.

* convenience accessors for global queues

```objc
+ (GCDQueue *)mainQueue;
+ (GCDQueue *)globalQueue;
+ (GCDQueue *)highPriorityGlobalQueue;
+ (GCDQueue *)lowPriorityGlobalQueue;
+ (GCDQueue *)backgroundPriorityGlobalQueue;
```

* testing the current execution context

```objc
+ (BOOL)isMainQueue;
```

* creating serial and concurrent queues

```objc
- (instancetype)initSerial;
- (instancetype)initConcurrent;
```

* queueing blocks for asynchronous execution

```objc
- (void)queueBlock:(dispatch_block_t)block;
- (void)queueBlock:(dispatch_block_t)block afterDelay:(double)seconds;
- (void)queueBlock:(dispatch_block_t)block inGroup:(GCDGroup *)group;
```

* queueing blocks for synchronous execution

```objc
- (void)queueAndAwaitBlock:(dispatch_block_t)block;
- (void)queueAndAwaitBlock:(void (^)(size_t))block iterationCount:(size_t)count;
```

* queueing barrier blocks for synchronous or asynchronous execution

```objc
- (void)queueBarrierBlock:(dispatch_block_t)block;
- (void)queueAndAwaitBarrierBlock:(dispatch_block_t)block;
```

* queueing notify blocks on groups

```objc
- (void)queueNotifyBlock:(dispatch_block_t)block inGroup:(GCDGroup *)group;
```

* suspending and resuming a queue

```objc
- (void)suspend;
- (void)resume;
```

* associating context data with a key

```objc
- (void *)contextForKey:(const void *)key;
- (void)setContext:(void *)context forKey:(const void *)key;
```

## GCDSemaphore

Semaphores are implemented in the __GCDSemaphore__ class.

* creating semaphores

```objc
- (instancetype)init;
- (instancetype)initWithValue:(long)value;
```

* signaling and waiting on a semaphore

```objc
- (BOOL)signal;
- (void)wait;
- (BOOL)wait:(double)seconds;
```

## GCDGroup

Groups are implemented in the __GCDGroup__ class.

* creating groups

```objc
- (instancetype)init;
```

* entering and leaving a group

```objc
- (void)enter;
- (void)leave;
```

* waiting on completion of a group

```objc
- (void)wait;
- (BOOL)wait:(double)seconds;
```

## Macros

Two macros are provided for wrapping __dispatch_once()__ calls.

* executing a block only once: __GCDExecOnce(block)__

```objc
for (int i = 0; i < 10; ++i) {
    GCDExecOnce(^{ NSLog(@"This will only be logged once."); });
}
```

* creating a singleton instance of a class: __GCDSharedInstance(block)__

```objc
+ (instancetype)sharedInstance {
  GCDSharedInstance(^{ return [self new]; });
}
```

The block supplied to __GCDSharedInstance()__ must return an instance of the desired class.
