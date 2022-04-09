<script lang="ts">

	import { emit, listen } from '@tauri-apps/api/event'
	import { onMount } from 'svelte';

	$: entries = []


	onMount(async () => {
		await listen('card_update', async event => {
			entries = await (await fetch("http://localhost:8000/get")).json()
		});
		emit("card_update");
	})

</script>

<div class = "container">
	<table class="table table-dark">
		<thead>
			<tr>
				<th scope="col">id</th>
				<th scope="col">name</th>
				<th scope="col">test_key</th>
			</tr>
		</thead>
		<tbody>
			{#key entries}
				{#each entries as entry}
					<tr>
						<th scope="row">{entry.id}</th>
						<td>{entry.name}</td>
						<td>{entry.data.test_key}</td>
					</tr>
				{/each}
			{/key}
		</tbody>
	</table>
</div>