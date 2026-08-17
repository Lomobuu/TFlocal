import { useState } from 'react'

export default function App() {
  const [count, setCount] = useState(0)

  return (
    <main className="card">
      <h1>react-demo</h1>
      <p className="sub">
        Built with Vite, served by nginx, pulled from ACR.
      </p>

      <button onClick={() => setCount((c) => c + 1)}>
        clicked {count} {count === 1 ? 'time' : 'times'}
      </button>

      <p className="hint">
        If this counter works, the bundle was served and React hydrated.
      </p>
    </main>
  )
}
